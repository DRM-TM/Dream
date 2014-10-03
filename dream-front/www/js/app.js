var dream = angular.module('dream', ['ionic', 'dream.controllers', 'dream.services']);

dream.config(function ($compileProvider) {
  $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|ftp|mailto|file|tel):/);
})

dream.config(['$stateProvider', '$urlRouterProvider',
function($stateProvider, $urlRouterProvider) {
  // Ionic uses AngularUI Router which uses the concept of states
  // Learn more here: https://github.com/angular-ui/ui-router
  // Set up the various states which the app can be in.
  // Each state's controller can be found in controllers.js
  $stateProvider
  .state('login', {
    url: '/login',
    controller: 'LoginController',
    templateUrl: 'templates/login.html'
  })
  .state('feed', {
    url: '/feed',
    controller: 'FeedController',
    templateUrl: 'templates/feed.html'
  })
  .state('record', {
    url: '/record',
    controller: 'RecordController',
    templateUrl: 'templates/record.html'
  })
  .state('settings', {
    url: '/settings',
    controller: 'SettingsController',
    templateUrl: 'templates/settings.html'
  });

  // if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise('/feed');
}
])
