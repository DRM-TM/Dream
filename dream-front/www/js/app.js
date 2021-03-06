var dream = angular.module('dream', ['ionic', 'dream.controllers', 'dream.services', 'ngCordova'])

.run(function($ionicPlatform, $cordovaOauth) {
  $ionicPlatform.ready(function() {
    // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
    // for form inputs)
    if(window.cordova && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
    }
    if(window.StatusBar) {
      // org.apache.cordova.statusbar required
      StatusBar.styleDefault();
    }
    ionic.Platform.isFullScreen = true;
  });
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
  .state('about', {
    url: '/about',
    controller: 'AboutController',
    templateUrl: 'templates/about.html'
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
