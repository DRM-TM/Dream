var ctrl = angular.module('dream.controllers', ['ionic']);

ctrl.controller('MenuController', function ($scope, $location, MenuService) {
  // "MenuService" is a service returning mock data (services.js)
  $scope.list = MenuService.all();

  $scope.toggleLeft = function() {
    $ionicSideMenuDelegate.toggleLeft();
  };

  $scope.goTo = function(page) {
    console.log('Going to ' + page);
    //$scope.sideMenuController.toggleLeft();
    $location.url('/' + page);
  };
})
