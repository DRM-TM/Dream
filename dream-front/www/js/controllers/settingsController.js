angular.module('dream.controllers').controller('SettingsController', function ($scope) {
  $scope.navTitle = "Page Three Title";

  $scope.leftButtons = [{
    type: 'button-icon icon ion-navicon',
    tap: function(e) {
      $scope.sideMenuController.toggleLeft();
    }
  }];

  $scope.rightButtons = [];
});
