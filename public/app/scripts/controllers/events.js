function EventsCtrl($scope, $route, Events) {
  $scope.events = Events.index();
}

// function LocationsCtrl($scope, $route, Events) {
//   $scope.events = Events.index();
// }

// function EventsCtrl($scope, $route, Events) {
//   $scope.events = Events.index();
// }

// function EventsCtrl($scope, $route, Events) {
//   $scope.events = Events.index();
// }

// function PhoneDetailCtrl($scope, $routeParams, Phone) {
//   $scope.phone = Phone.get({phoneId: $routeParams.phoneId}, function(phone) {
//     $scope.mainImageUrl = phone.images[0];
//   });

//   $scope.setImage = function(imageUrl) {
//     $scope.mainImageUrl = imageUrl;
//   }
// }