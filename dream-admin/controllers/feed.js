app.controller('FeedController', ['$http', '$scope', '$cookieStore','sha1', function($http, $scope,$cookieStore ,sha1) {

	var feed = this;
	var apiPath = 'http://62.210.252.91:15030/api';
	this.dreams = [];
	this.showDream = -1;
	this.showComment = -1;
	this.tag = {text:''};
	this.comment = {text:''};
	this.dreamContent = {text:''};
	this.display = "login";
	this.userId = 40;

	this.getDisplay = function() {
		if (!$cookieStore.get("logged")) {
			feed.display = "login";
		}
		else if ($cookieStore.get("logged")) {
			feed.display = "dreams";
			feed.getFeed();
		}
		else {
			feed.display = "login";
			$cookieStore.put("logged", false);
		}
	}

	this.toggle = function(index, show) {
		if (show == index)
			return -1;
		else
			return index;
	}

	this.getFeed = function() {
		$http.get(apiPath + '/dream').
  		success(function(data) {
    	// this callback will be called asynchronously
    	// when the response is available
    		feed.dreams = data;
    	}).
  		error(function(data) {
    	// called asynchronously if an error occurs
    	// or server returns response with an error status.
    		feed.dreams = ["lol"];

		});
		return "dreams";
	}

	this.addDream = function() {
		var path = apiPath + '/dream';
		if (this.dreamContent.text) {	
			$http({ method:'POST',
					url:path,
					data:{"uid":feed.userId, "category_id":1, "content":this.dreamContent.text}
					}).
			success(function() {
				feed.getFeed()
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
			feed.getFeed()
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
						"uid":feed.userId,
						"category_id":parseInt(this.dreams[index].content.m_category_id),
						"content":this.dreams[index].content.m_content}
			}).
		success(function() {
			feed.getFeed();
		}).
		error(function() {
			feed.getFeed();
			alert("update dream fail")
		});
		return false;
	}

	this.deleteTag = function(index) {
		var path = apiPath + '/hashtag/' + index;
		$http.delete(path).
		success(function() {
			feed.getFeed()
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
					data:{"uid":feed.userId, "dream_id":parseInt(id), "content":"#" + this.tag.text},
					}).
			success(function() {
				feed.getFeed()
			}).
			error(function() {
				alert("post fail : " + id)
			});
			this.tag.text = '';
		}
		return false;
	}

	this.updateTag = function(id, dream_id, index, dream_index) {
		var path = apiPath + '/hashtag';

		$http({ method:'PUT',
				url:path,
				data:{	"actual_id":parseInt(id),
						"uid":feed.userId, 
						"dream_id":parseInt(dream_id), 
						"content":this.dreams[dream_index].hashtags[index].m_content }
			}).
		success(function() {
			feed.getFeed()
		}).
		error(function() {
			alert("post fail : " + id)
		});
	}

	this.addComm = function(id) {
		var path = apiPath + '/comment';
		if (this.comment.text) {
			$http({	method:'POST',
					url:path,
					data:{"uid":feed.userId, "dream_id":parseInt(id), "content":this.comment.text},
					}).
			success(function() {
				feed.getFeed()
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
			feed.getFeed()
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
						"uid":feed.userId, 
						"dream_id":parseInt(dream_id), 
						"content":this.dreams[dream_index].comments[index].m_content }
			}).
		success(function() {
			feed.getFeed()
		}).
		error(function() {
			alert("post fail : " + id)
		});
		return false;
	}

	this.alert = function() {
		alert("Alerte")
	}

	this.users = [];
	this.newUser = {	
		username:'',
		email:'',
		birthdate:'',
		password:''
	};

	this.getUsers = function() {
		$http.get(apiPath + '/user').
		success(function(data) {
			feed.users = data
			feed.users = feed.users.reverse();
		}).
		error(function(data) {
			alert("get users fail")
		});
		return "users";
	}

	this.addUser = function() {
		var path = apiPath + "/user";
		$http({ method:'POST',
				url:path,
				data:{	"email":this.newUser.email, 
						"password":sha1.encode(this.newUser.password), 
						"token":"", 
						"birthdate":this.newUser.birthdate, 
						"username":this.newUser.username }
				}).
		success(function() {
			feed.getUsers()
		}).
		error(function() {
			alert("Add user fail")
		});
	}

	this.deleteUser = function(id) {
		var path = apiPath + "/user/" + id;
		$http.delete(path).
		success(function() {
			feed.getUsers()
		}).
		error(function() {
			alert("Delete fail")
		});
	}

	this.updateUser = function(id, index) {
		var path = apiPath + "/user"
		$http({ method:'PUT',
				url:path,
				data:{	"actual_id":parseInt(id),
						"email":feed.users[index].m_email, 
						"password":feed.users[index].m_password, 
						"token":"", 
						"birthdate":feed.users[index].m_birthdate, 
						"username":feed.users[index].m_username }
				}).
		success(function() {
			feed.getUsers()
		}).
		error(function() {
			alert("Update user fail")
		});
		return false;
	}

	this.cancelUpdate = function() {
		feed.getUsers();
		return false;
	}

	this.email = '';
	this.password = '';
	this.logUser = function() {
		var path = apiPath + '/user/login';
		if (this.email != '' && this.password != '') {
			$http({
				method:'POST',
				url:path,
				data:{'email':feed.email, 'hash':sha1.encode(feed.password)}
			}).
			success(function(data) {
				feed.userId = parseInt(data.m_id);
				$cookieStore.put("logged", true);
				feed.display = "dreams";
				feed.getUsers();
				feed.getFeed();
			}).
			error(function() {
				alert("Login failed")
			});
		}
	}

}]);
