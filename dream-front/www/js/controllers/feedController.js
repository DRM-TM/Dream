var dreams = []
//Controller handling API call and result display
angular.module('dream.controllers').controller('FeedController', function ($scope, $ionicViewService, $http, $log, FeedService, HardwareBackButtonManager) {
  $scope.navTitle = "Dream feed"
  $scope.list = FeedService.all()


  //re-enable hardware back button
  HardwareBackButtonManager.enable()

  $http.get('https://mimiks.net:15030/api/dream').
  success(function(data, status, headers, config) {
    $scope.list = data
    $log.log(data)
  }).error(function(data, status, headers, config) {
    $scope.list = {}
    $log.log("Error querying dreams for dream feed")
  });

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
