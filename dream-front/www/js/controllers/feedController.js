//Controller handling API call and result display
angular.module('dream.controllers').controller('FeedController', function ($scope, $ionicViewService, FeedService, HardwareBackButtonManager) {
  $scope.navTitle = "Dream feed";
  $scope.list = FeedService.all()

  //re-enable hardware back button
  HardwareBackButtonManager.enable();

  //reset nav history to prevent back button error
  $ionicViewService.clearHistory()

  $scope.leftButtons = [{
    type: 'button-icon icon ion-navicon',
    tap: function(e) {
      $scope.sideMenuController.toggleLeft();
    }
  }];

  $scope.rightButtons = [];
})
