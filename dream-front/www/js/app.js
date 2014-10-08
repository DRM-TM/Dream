var dream = angular.module('dream', ['ionic', 'dream.controllers', 'dream.services'])

.config(function ($compileProvider) {
  $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|ftp|mailto|file|tel):/);
})

.config(['$stateProvider', '$urlRouterProvider',
function($stateProvider, $urlRouterProvider) {
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
  $urlRouterProvider.otherwise('/login');
}
]);
