angular.module('dream.controllers').controller('RecordController', function ($scope) {
  $scope.navTitle = "Record";

  $scope.leftButtons = [{
    type: 'button-icon icon ion-navicon',
    tap: function(e) {
      $scope.sideMenuController.toggleLeft();
    }
  }];

  $scope.rightButtons = [];
})
