function EventsCtrl($scope, $routeParams, Events) {
  $scope.events = Events.query();
}

function EventCtrl($scope, $routeParams, Event, Location) {
  $scope.event = Event.get({
    id: $routeParams.id
  });
}

var getChildCategories = function (parentId, allCategories) {
  /*
    Method returns an array of categories whos parent is
    the category with parentId.
    @param {String|null} parentId - id of parent category or null
                        if what you want is the top level categories.
    @param {Array} allCategories - all available categories
    @return {Array} - list of child categories for parentId
   */
  var filteredCategories = [];
  for (var i = 0, len = allCategories.length; i < len; i ++) {
    var currentCategory = allCategories[i]
    if (''+currentCategory.parent_id === ''+parentId) {
      filteredCategories.push(currentCategory);
    }
  }
  return filteredCategories;
};

function CategoriesCtrl ($scope, $routeParams, $location, Categories) {
  isIdInRoute = $routeParams.id != undefined && $routeParams.id !== ''

  $scope.categories = Categories.query({}, function(){
    if (isIdInRoute === true) {
      children = getChildCategories($routeParams.id, $scope.categories);
      hasChildren = children.length > 0
      if (hasChildren === true) {
        $scope.categories = children;
      }
      else {
        $location.path('/categories/'+$routeParams.id+'/events');
      }
    }
    else {
      topLevelCategories = getChildCategories(null, $scope.categories);
      $scope.categories = topLevelCategories;
    }
  });
}

function CategoryCtrl($scope, $routeParams, Category) {
  $scope.category = CategoryEvents.get({
    id: $routeParams.id
  });
}

// function LocationCtrl($scope, $routeParams, Location) {
//   $scope.location = Location.query();
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