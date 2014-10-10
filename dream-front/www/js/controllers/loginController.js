//Controller handling user connection
ctrl.controller('LoginController', function ($scope, $location) {
  $scope.navTitle = "Login";

  //get credentials fro mthe login page and try to authentificate the user with the database infos
  $scope.login = function(user) {
    if (user.email == "root" && user.password == "root") {
      $location.path("/feed");
      window.localStorage['isLogged'] = "true"
      window.localStorage['userEmail'] = user.email
      console.log(window.localStorage['userEmail'])
    }
    $scope.log = "ERROR : You tried to log in with the following credentials" + user.email + " " + user.password
  }

  $scope.leftButtons = [{
    type: 'button-icon icon ion-navicon',
    tap: function(e) {
      $scope.sideMenuController.toggleLeft();
    }
  }];

  $scope.rightButtons = [];
});
