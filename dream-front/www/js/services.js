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
});
