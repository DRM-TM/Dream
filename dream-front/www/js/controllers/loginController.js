//Controller handling user connection
ctrl.controller('LoginController', function ($scope,
  $http,
  $location,
  $cordovaOauth,
  StorageService,
  $ionicSideMenuDelegate,
  HardwareBackButtonManager) {

    $scope.navTitle = "Login";

    //remove menu drag to open
    $ionicSideMenuDelegate.canDragContent(false)
    //disable hardware back button
    HardwareBackButtonManager.disable();
    /*
    ** get credentials from the login page and try to auth the user
    ** save the user id in the local storage
    */
    $scope.login = function(user) {
      if (user.email == "root" && user.password == "root") {
        $location.path("/feed");
        StorageService.set("isLogged", "true");
        StorageService.set("userID", user.email);
        console.log(window.localStorage['userEmail'])
      }
      $scope.log = "ERROR : You tried to log in with the following credentials"
      + user.email +
      " " + user.password
    }

    // if there there is no data
    if(window.Connection) {
      if(navigator.connection.type == Connection.NONE) {
        $ionicPopup.confirm({
          title: "Internet Disconnected",
          content: "The internet is disconnected on your device."
        })
        .then(function(result) {
          if(!result) {
            ionic.Platform.exitApp();
          }
        });
      }
    }


    //login the user using the facebook API
    $scope.loginFB = function(user) {
      $cordovaOauth.facebook("1485303221747100", []).then(function(result) {
        auth("https://graph.facebook.com/me?fields=id&access_token=" + result.access_token)
      }, function(error) {
        $scope.fb = error;
      });

      //get the facebook user id coresponding to the access_token
      function auth(addr){
        $http.get(addr).
        success(function(data, status, headers, config) {
          StorageService.set("userID", data.id);
          $location.path("/feed");
        }).error(function(data, status, headers, config) {
          $scope.fb = "Authentification failed : unknown error.";
        });
      }
    }
  });
