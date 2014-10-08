//Controller handling API call and result display
angular.module('dream.controllers').controller('FeedController', function ($scope, FeedService) {
  $scope.navTitle = "Dream feed";
  $scope.list = FeedService.all()


  $scope.leftButtons = [{
    type: 'button-icon icon ion-navicon',
    tap: function(e) {
      $scope.sideMenuController.toggleLeft();
    }
  }];

  $scope.rightButtons = [];
})
