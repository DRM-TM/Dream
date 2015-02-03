(function(){

var app = angular.module('feed', []);

app.controller('FeedController', ['$http', '$scope', function($http, $scope) {

	var feed = this;
	this.dreams = [];
	this.showDream = -1;
	this.showComment = -1;

	this.toggle = function(index, show) {
		if (show == index)
			return -1
		else
			return index
	}

	this.deleteDream = function(index) {
		var path = 'https://mimiks.net:15030/api/dream' + index;
		$http.delete(path).
		success(function() {
			alert("Delete success")
		}).
		error(function() {
			alert("Delete fail")
			// body...
		});
	}
	
	this.updateDream = function(content, index) {
		alert("LOL");
	}

	this.alert = function() {
		alert("Alerte")
	}

	$http.get('https://mimiks.net:15030/api/dream').
  	success(function(data) {
    // this callback will be called asynchronously
    // when the response is available
    	feed.dreams = data;
    	feed.dreams.push(moderate="true");
    }).
  	error(function(data) {
    // called asynchronously if an error occurs
    // or server returns response with an error status.
    	feed.dreams = ["lol"];

	});
}]);



})();