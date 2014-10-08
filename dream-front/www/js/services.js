angular.module('dream.services', [])

/**
 * A simple example service that returns some data.
 */
.factory('MenuService', function() {

  var menuItems = [
      { text: 'Dream feed', iconClass: 'icon ion-cloud', link: 'feed'},
      { text: 'Record', iconClass: 'icon ion-edit', link: 'record'},
      { text: 'Settings', iconClass: 'icon ion-gear-a', link: 'settings'}
  ];

  return {
    all: function() {
      return menuItems;
    }
  }
})

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
});
