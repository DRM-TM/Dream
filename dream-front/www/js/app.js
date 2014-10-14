var dream = angular.module('dream', ['ionic', 'dream.controllers', 'dream.services'])

.run(function(HardwareBackButtonManager)
{
  //disable hardware back button
  HardwareBackButtonManager.disable();
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
  })
  .state('intro', {
    url: '/',
    controller: 'IntroController',
    templateUrl: 'templates/intro.html'
  });

  // if none of the above states are matched, use this as the fallback
    $urlRouterProvider.otherwise('/');
}
]);
