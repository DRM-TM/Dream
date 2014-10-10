ctrl.controller('RecordController', function ($scope, $ionicPopup) {
  $scope.navTitle = "Record";


//popup function for text and microphone recording
$scope.showPopup = function(templateUrl, title, errorMessage) {
  $scope.data = {}
  $scope.errorMessage = ""

  var myPopup = $ionicPopup.show({
    templateUrl: templateUrl,
    title: title,
    scope: $scope,
    buttons: [
    { text: 'Cancel' },
    {
      text: '<b>Save</b>',
      type: 'button-positive',
      onTap: function(e) {
        if (!$scope.data.dream) {
          $scope.errorMessage = errorMessage
          e.preventDefault();
        } else {
          //process datas
          return $scope.data;
        }
      }
    },
    ]
  });
  myPopup.then(function(res) {
    myPopup.close()
    console.log('Dream recorded', res);
  });
};

  $scope.leftButtons = [{
    type: 'button-icon icon ion-navicon',
    tap: function(e) {
      $scope.sideMenuController.toggleLeft();
    }
  }];

  $scope.rightButtons = [];
})
