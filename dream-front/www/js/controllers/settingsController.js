angular.module('dream.controllers').controller('SettingsController', function ($scope) {
  $scope.navTitle = "Settings";

  $scope.leftButtons = [{
    type: 'button-icon icon ion-navicon',
    tap: function(e) {
      $scope.sideMenuController.toggleLeft();
    }
  }];

  $scope.rightButtons = [];
});
