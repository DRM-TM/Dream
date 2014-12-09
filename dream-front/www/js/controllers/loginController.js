//Controller handling user connection
ctrl.controller('LoginController', function ($scope,
  $http,
  $location,
  $cordovaOauth,
  StorageService,
  $ionicSideMenuDelegate,
  HardwareBackButtonManager,
  $ionicPopup,
  sha1) {

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
      $http.post('https://mimiks.net:15030/api/user/login', {email:user.email, hash:sha1.encode(user.password)}).
      success(function(data, status, headers, config) {
        if (data == "true") {
          $scope.error = "string";
          $location.path("/feed");
          StorageService.set("isLogged", "true");
          StorageService.set("userEmail", user.email);
          StoragePassword.set("userPassword", sha1.encode(user.password));
        }
      }).
      error(function(data, status, headers, config) {
        console.log(data);
        console.log("Failder to log user")
        $scope.error = "failed to log";
      });
    }

    //login the user using the facebook API
    $scope.loginFB = function(user) {
      $cordovaOauth.facebook("1485303221747100", []).then(function(result) {
        auth("https://graph.facebook.com/me?fields=id&access_token=" + result.access_token)
      }, function(error) {
        $scope.error = error;
      });

      //get the facebook user id coresponding to the access_token
      function auth(addr){
        $http.get(addr).
        success(function(data, status, headers, config) {
          StorageService.set("userID", data.id);
          $location.path("/feed");
        }).error(function(data, status, headers, config) {
          $scope.error = "Authentification failed : unknown error.";
        });
      }
    }

    $scope.showPopup = function(templateUrl, title, errorMessage) {
      $scope.data = {}

      var myPopup = $ionicPopup.show({
        templateUrl: templateUrl,
        scope: $scope,
        id: "recovery-popup",
        buttons: [
        {
          text: 'Cancel',
          type: 'button-recovery'
        },
        {
          text: '<b>Send</b>',
          type: 'button-dark button-recovery',
          onTap: function(e) {
            if (!$scope.data.email) {
              $scope.errorMessage = errorMessage
              e.preventDefault();
              console.log(errorMessage)
            } else {
              console.log($scope.data)
              return $scope.data;
            }
          }
        },
        ]
      });
      myPopup.then(function(res) {
        myPopup.close()
        console.log('Record popup closed', res);
      });
    };

  });
