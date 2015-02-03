(function(){

var app = angular.module('feed', []);

app.controller('FeedController', ['$http', '$scope', function($http, $scope) {

	var feed = this;
	var apiPath = 'https://mimiks.net:15030/api';
	this.dreams = [];
	this.showDream = -1;
	this.showComment = -1;
	this.tag = {text:''};

	this.toggle = function(index, show) {
		if (show == index)
			return -1
		else
			return index
	}

	this.deleteDream = function(index) {
		var path = apiPath + '/dream/' + index;
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

	this.deleteTag = function(index) {
		var path = apiPath + '/hashtag/' + index;
		$http.delete(path).
		success(function() {
			alert("Delete success")
		}).
		error(function() {
			alert("Delete fail")
		}); 
	}

	this.addTag = function(index) {
		var path = apiPath + '/hashtag';
		if (this.tag.text) {
			$http({	method:'POST',
					url:path,
					data:{"uid":"1", "hashtag_id":index, "content":this.tag.text},
					headers:{'Access-Control-Allow-Origin': '*'}}).
			success(function() {
				alert("post success")
			}).
			error(function() {
				alert("post fail : " + feed.tag.text)
			});
			/*this.tag.text = '';*/
		}
	}

	this.alert = function() {
		alert("Alerte")
	}

	$http.get(apiPath + '/dream').
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