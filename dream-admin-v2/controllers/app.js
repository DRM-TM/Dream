(function(){

var app = angular.module('feed', []);

app.controller('FeedController', ['$http', '$scope', function($http, $scope) {

	var feed = this;
	var apiPath = 'http://localhost:15030/api';
	this.dreams = [];
	this.showDream = -1;
	this.showComment = -1;
	this.tag = {text:''};
	this.comment = {text:''};
	this.dreamContent = {text:''};

	this.toggle = function(index, show) {
		if (show == index)
			return -1;
		else
			return index;
	}

	$scope.getFeed = function() {
		$http.get(apiPath + '/dream').
  		success(function(data) {
    	// this callback will be called asynchronously
    	// when the response is available
    		feed.dreams = data;
    		feed.dreams = feed.dreams.reverse();
//    		feed.dreams.push(moderate="true");
    	}).
  		error(function(data) {
    	// called asynchronously if an error occurs
    	// or server returns response with an error status.
    		feed.dreams = ["lol"];

		});
	}

	this.addDream = function() {
		var path = apiPath + '/dream';
		if (this.dreamContent.text) {	
			$http({ method:'POST',
					url:path,
					data:{"uid":1, "category_id":1, "content":this.dreamContent.text}
					}).
			success(function() {
				$scope.getFeed()
			}).
			error(function() {
				alert("Add dream fail")
			});
			this.dreamContent.text = '';
		}
	}

	this.deleteDream = function(index) {
		var path = apiPath + '/dream/' + index;
		$http.delete(path).
		success(function() {
			$scope.getFeed()
		}).
		error(function() {
			alert("Delete fail")
			// body...
		});
	}
	
	this.updateDream = function(id, index) {
		var path = apiPath + '/dream';
		$http({ method:'PUT',
				url:path,
				data:{	"actual_id":parseInt(id), 
						"uid":1,
						"category_id":parseInt(this.dreams[index].content.m_category_id),
						"content":this.dreams[index].content.m_content}
			}).
		success(function() {
			$scope.getFeed();
		}).
		error(function() {
			$scope.getFeed();
			alert("update dream fail")
		});
		return false;
	}

	this.deleteTag = function(index) {
		var path = apiPath + '/hashtag/' + index;
		$http.delete(path).
		success(function() {
			$scope.getFeed()
		}).
		error(function() {
			alert("Delete fail")
		}); 
	}

	this.addTag = function(id) {
		var path = apiPath + '/hashtag';
		this.tag.text = this.tag.text.replace(' ', '');
		if (this.tag.text) {
			$http({	method:'POST',
					url:path,
					data:{"uid":1, "dream_id":parseInt(id), "content":"#" + this.tag.text},
					}).
			success(function() {
				$scope.getFeed()
			}).
			error(function() {
				alert("post fail : " + id)
			});
			this.tag.text = '';
		}
		return false;
	}

	this.addComm = function(id) {
		var path = apiPath + '/comment';
		if (this.comment.text) {
			$http({	method:'POST',
					url:path,
					data:{"uid":1, "dream_id":parseInt(id), "content":this.comment.text},
					}).
			success(function() {
				$scope.getFeed()
			}).
			error(function() {
				alert("post fail : " + id)
			});
			this.comment.text = '';
		}
		return false;
	}

	this.deleteComm = function(id) {
		var path = apiPath + '/comment/' + id;
		$http.delete(path).
		success(function() {
			$scope.getFeed()
		}).
		error(function() {
			alert("Delete fail : " + id)
		});
	}

	this.updateComm = function(id, dream_id, index, dream_index) {
		var path = apiPath + '/comment';
		$http({ method:'PUT',
				url:path,
				data:{	"actual_id":parseInt(id),
						"uid":1, 
						"dream_id":parseInt(dream_id), 
						"content":this.dreams[dream_index].comments[index].m_content }
			}).
		success(function() {
			$scope.getFeed()
		}).
		error(function() {
			alert("post fail : " + id)
		});
		return false;
	}

	this.alert = function() {
		alert("Alerte")
	}

	$scope.getFeed();
}]);



})();