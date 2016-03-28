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
  $scope.title = 'Categories';
}

function CategoryCtrl($scope, $routeParams, CategoryEvents) {
  $scope.events = CategoryEvents.query({
    id: $routeParams.id
  });
}

function TopNavCtrl ($scope, $location) {
  $scope.$on('$routeChangeStart', function () {
    if ($location.path() === '/') {
        $scope.title = 'Event App';
        $scope.showSettings = true;
        $scope.showSecondNav = true;
    }
    else if ($location.path().match(/\/events\/\d+/gi)) {
        $scope.title = 'Event';
        $scope.showBack = true;
        $scope.showSettings = false;
        $scope.showSecondNav = false;
    }
    else if ($location.path().match(/\/categories\/\d+\/events/gi)) {
        $scope.title = 'Categories';
        $scope.showBack = true;
        $scope.showSettings = false;
        $scope.showSecondNav = true;
    }
    else if ($location.path().match(/\/categories\/\d*/gi)) {
        $scope.title = 'Categories';
        $scope.showBack = true;
        $scope.showSettings = false;
        $scope.showSecondNav = false;
    }
    else if ($location.path() === '/location') {
        $scope.title = 'Location';
        $scope.showGps = true;
        $scope.showSettings = true;
        $scope.showSecondNav = true;
    }
    else if ($location.path() === '/settings') {
        $scope.title = 'Settings';
        $scope.showDone = true;
        $scope.showSettings = false;
        $scope.showSecondNav = false;
    }
    else if ($location.path() === '/profile') {
        $scope.title = 'My Profile';
        $scope.showSettings = true;
        $scope.showSecondNav = false;
    }
    else {
        $scope.title = 'Event App';
    }

  });
}

function BottomNavCtrl ($scope, $location) {
  $scope.$on('$routeChangeStart', function () {
    switch($location.path()) {
      case '/settings':
        $scope.showNav = false;
        break;
      default:
      $scope.showNav = true;
    }
  });
}

function LocationCtrl($scope, $routeParams, Geolocation) {
  $scope.location = Geolocation.position();
}

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