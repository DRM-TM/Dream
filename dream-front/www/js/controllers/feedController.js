//Controller handling API call and result display
angular.module('dream.controllers').controller('FeedController', function ($scope) {
  $scope.navTitle = "Feed";

  $scope.leftButtons = [{
    type: 'button-icon icon ion-navicon',
    tap: function(e) {
      $scope.sideMenuController.toggleLeft();
    }
  }];

  $scope.rightButtons = [];
})
