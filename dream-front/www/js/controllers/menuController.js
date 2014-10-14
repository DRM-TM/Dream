var ctrl = angular.module('dream.controllers', ['ionic']);

ctrl.controller('MenuController', function ($scope, $location, MenuService) {
  // mock data
  $scope.list = MenuService.all();
  $scope.toggleLeft = function() {
    $ionicSideMenuDelegate.toggleLeft();
  };
  //redirect the user to the link clicked and close the menu
  $scope.goTo = function(page) {
    console.log('Going to ' + page);
    $location.url('/' + page);
  };
})
