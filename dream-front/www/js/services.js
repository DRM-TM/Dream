angular.module('dream.services', [])

/*
** menu content
*/
.factory('MenuService', function() {

  var menuItems = [
  { text: 'Dream feed', iconClass: 'icon ion-cloud', link: 'feed'},
  { text: 'Settings', iconClass: 'icon ion-ios7-gear', link: 'settings'}
  ];

  return {
    all: function() {
      return menuItems;
    }
  }
})

/*
** mock datas for the feed
*/

.factory('FeedService', function() {
  var dreamItems = [
  {title:'Dream test', text:'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'},
  {title:'Test 2', text:'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'},
  {title:'Test 3', text:'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.'},
  {title:'Test 4', text:'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.'},
  {title:'Test 5', text:'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.'}
  ];
  return {
    all: function() {
      return dreamItems
    }
  }
})

/*
** Back button manager
*/
.service( 'HardwareBackButtonManager', function($ionicPlatform){
  this.deregister = undefined;

  this.disable = function(){
    this.deregister = $ionicPlatform.registerBackButtonAction(function(e){
      e.preventDefault();
      return false;
    }, 101);
  }

  this.enable = function(){
    if( this.deregister !== undefined ){
      this.deregister();
      this.deregister = undefined;
    }
  }
  return this;
})


/*
** simpler local storage access
*/

.factory('StorageService', ['$window', function($window) {
  return {
    dump : function(key){
      console.log($window.localStorage[key])
    },
    set: function(key, value) {
      $window.localStorage[key] = value;
    },
    get: function(key, defaultValue) {
      return $window.localStorage[key] || defaultValue;
    },
    setObject: function(key, value) {
      $window.localStorage[key] = JSON.stringify(value);
    },
    getObject: function(key) {
      return JSON.parse($window.localStorage[key] || '{}');
    },
    clean: function() {
      $window.localStorage.clear()
    }
  }
}]);
