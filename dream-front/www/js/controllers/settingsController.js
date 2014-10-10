ctrl.controller('SettingsController', function ($scope, $ionicPopup, StorageService) {
  $scope.navTitle = "Settings"

  $scope.edit_user_infos = "Edit your informations"
  $scope.feed_options = "Feed"

  StorageService.set("autoSharing", "false")
  StorageService.set("private", "false")
  StorageService.set("mature", "false")

  //store checkboxes changes in local storage
  $scope.test = function(toChange) {
    if (StorageService.get(toChange) == "true") {
      StorageService.set(toChange, "false")
    } else {
      StorageService.set(toChange, "true")
    }
    console.log("autoSharing :" + StorageService.get("autoSharing"))
    console.log("private :" +StorageService.get("private"))
    console.log("mature :" +StorageService.get("mature"))
    console.log("------------------------")
  }

  //store banned tags in local storage as bannedTags
  $scope.addTags = function(tags) {
    var bannedTags = tags.replace(/\s/g, "").split(',')
    StorageService.set('bannedTags', JSON.stringify(bannedTags))
    StorageService.dump('bannedTags')
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

  $scope.leftButtons = [{
    type: 'button-icon icon ion-navicon',
    tap: function(e) {
      $scope.sideMenuController.toggleLeft();
    }
  }];

  $scope.rightButtons = [];
});
