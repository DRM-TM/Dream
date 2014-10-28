ctrl.controller('AboutController', function ($scope, $ionicPopup) {
  $scope.navTitle = "About us";


  $scope.leftButtons = [{
    type: 'button-icon icon ion-navicon',
    tap: function(e) {
      $scope.sideMenuController.toggleLeft();
    }
  }];

  $scope.rightButtons = [];
})
