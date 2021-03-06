ctrl.controller('SettingsController', function ($scope, $ionicPopup, $timeout, StorageService, HardwareBackButtonManager, $ionicSideMenuDelegate) {
  $scope.navTitle = "Settings"

  $scope.dream_options = "Dream options"
  $scope.feed_options = "Feed options"

  StorageService.set("autoSharing", "false")
  StorageService.set("private", "false")
  StorageService.set("mature", "false")

  //re-enable hardware back button
  HardwareBackButtonManager.enable();

  //store checkboxes changes in local storage
  $scope.test = function(toChange) {
    if (StorageService.get(toChange) == "true") {
      StorageService.set(toChange, "false")
    } else {
      StorageService.set(toChange, "true")
    }
    // console.log("autoSharing :" + StorageService.get("autoSharing"))
    // console.log("private :" +StorageService.get("private"))
    // console.log("mature :" +StorageService.get("mature"))
    // console.log("------------------------")
  }

  /*
  **ugly fix to send a request to the api only when the user re-open the
  **menu from the settings page.
  */

  $scope.$watch(function () {
    return $ionicSideMenuDelegate.getOpenRatio();
  },
  function (ratio) {
    if (ratio == 1){
      console.log("if there is a modification, send it to the server");
    }
  });

  //store banned tags in local storage as bannedTags
  $scope.addTags = function(tags) {
    var bannedTags = tags.replace(/\s/g, "").split(',');
    StorageService.set('bannedTags', JSON.stringify(bannedTags));
    StorageService.dump('bannedTags');
  }

  $scope.clearLocalStorage = function() {
    StorageService.clean();
    console.log("local storage cleared by user");
    $scope.data = {};
    $scope.errorMessage = "";

    var myPopup = $ionicPopup.show({
      title:"Local storage clear",
      scope: $scope,

    });
    myPopup.then(function(res) {
      myPopup.close()
      console.log('Profile settings saved', res);
    });
    $timeout(function() {
      myPopup.close();
    }, 1000);
  }

  //popup function for email and password modification
  $scope.showEditPopup = function() {
    $scope.data = {}
    $scope.errorMessage = ""

    var myPopup = $ionicPopup.show({
      templateUrl: 'templates/popups/editUserInfos.html',
      title: 'Change your email or password',
      scope: $scope,
      buttons: [
      { text: 'Cancel' },
      {
        text: '<b>Save</b>',
        type: 'button-positive',
        onTap: function(e) {
          if (!$scope.data.email && !$scope.data.password) {
            $scope.errorMessage = "Nothing to update"
            e.preventDefault();
          }
          if ($scope.data.password != $scope.data.passwordVerif){
            $scope.errorMessage = "Passwords not matching"
            e.preventDefault();
          } else {
            //process datas
            return $scope.data;
          }
        }
      },
      ]
    });
    myPopup.then(function(res) {
      myPopup.close()
      console.log('Profile settings saved', res);
    });
  };
});
