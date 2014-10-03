angular.module('dream.controllers', []);

angular.module('dream.controllers').controller('MenuController', function ($scope, $location, MenuService) {
  // "MenuService" is a service returning mock data (services.js)
  $scope.list = MenuService.all();

  $scope.goTo = function(page) {
    console.log('Going to ' + page);
    $scope.sideMenuController.toggleLeft();
    $location.url('/' + page);
  };
})
