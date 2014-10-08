ctrl.controller('SettingsController', function ($scope, $ionicPopup, $timeout) {
  $scope.navTitle = "Settings"

  $scope.edit_user_infos = "Edit your informations"
  $scope.feed_options = "Feed"

  //function used to add banned tags
  $scope.addTags = function(tags) {
    console.log("debug tags")
    console.log(tags.split(","))
    console.log("-----end------")
  }

  //function used to show the popup for email/passwd change
  $scope.showEditPopup = function() {
    $scope.data = {}

    // An elaborate, custom popup
    var myPopup = $ionicPopup.show({
      template: '<input type="password" ng-model="data.wifi">',
      title: 'Enter Wi-Fi Password',
      subTitle: 'Please use normal things',
      scope: $scope,
      buttons: [
      { text: 'Cancel' },
      {
        text: '<b>Save</b>',
        type: 'button-positive',
        onTap: function(e) {
          if (!$scope.data.wifi) {
            //don't allow the user to close unless he enters wifi password
            e.preventDefault();
          } else {
            return $scope.data.wifi;
          }
        }
      },
      ]
    });
    myPopup.then(function(res) {
      console.log('Tapped!', res);
    });
    $timeout(function() {
      myPopup.close(); //close the popup after 3 seconds for some reason
    }, 3000);
  };

  $scope.leftButtons = [{
    type: 'button-icon icon ion-navicon',
    tap: function(e) {
      $scope.sideMenuController.toggleLeft();
    }
  }];

  $scope.rightButtons = [];
});
