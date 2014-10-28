
ctrl.controller('IntroController', function($scope, $location, $ionicSlideBoxDelegate, $ionicSideMenuDelegate, StorageService) {

  //remove menu drag to open
  $ionicSideMenuDelegate.canDragContent(false)

  //debug purpose only, clear the storage to get the intro everytime
  //window.localStorage.clear()
  $scope.goToApp = "Skip"

  $scope.intro_text_one = "Merci d'avoir choisi"
  $scope.intro_text_two = "Vous venez de télécharger l'appli la plus cool du monde"

  /*
  **if user already saw the intro, skip it
  **if user already logged in skip the login page
  */
  if (StorageService.get('introSeen') == "true") {
    if (StorageService.get('isLogged') == "true") {
      $location.url("/feed");
    } else {
      $location.url("/login");
    }
  }

  // Called to navigate to the main app
  $scope.startApp = function() {
    StorageService.set('introSeen', 'true')
    $location.url("/login");
  };
  $scope.next = function() {
    $ionicSlideBoxDelegate.next();
  };
  $scope.previous = function() {
    $ionicSlideBoxDelegate.previous();
  };

  // Called each time the slide changes
  $scope.slideChanged = function(index) {
    $scope.slideIndex = index;
  };
})
