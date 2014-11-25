ctrl.controller('RecordController', function ($scope, $ionicPopup) {
  $scope.navTitle = "Record";

$scope.errorMessage = "Looks like you forgot something."
  //popup function for text and microphone recording
  $scope.showPopup = function(templateUrl, title, errorMessage) {
    $scope.data = {}

    var myPopup = $ionicPopup.show({
      templateUrl: templateUrl,
      scope: $scope,
      id: "custom-popup",
      buttons: [
      { text: 'Cancel' },
      {
        text: '<b>Save</b>',
        type: 'button-dark',
        onTap: function(e) {
          if (!$scope.data.content) {
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
})
