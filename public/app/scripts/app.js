var eventsApp = angular.module('eventsApp', ['eventsService'])
  .config(function($routeProvider){
    // Configure the routes
    $routeProvider
      // List all events
      .when('/', {
        templateUrl: 'views/events.html',
        controller: 'EventsCtrl'
      })
      // List event
      .when('/events/:id', {
        templateUrl: 'views/event.html',
        controller: 'EventCtrl'
      })
      .when('/events/:id/details', {
        templateUrl: 'views/event-details.html',
        controller: 'EventCtrl'
      })
      .when('/categories/:id', {
        templateUrl: 'views/categories.html',
        controller: 'CategoriesCtrl'
      })
      .when('/categories/:id/events', {
        templateUrl: 'views/category.html',
        controller: 'CategoryCtrl'
      })
      .when('/settings', {
        templateUrl: 'views/settings.html'
      })
      .when('/location', {
        templateUrl: 'views/location.html',
        // controller: 'LocationCtrl'
      })
      // .when('/locations/:id', {
      //   templateUrl: 'views/location.html',
      //   controller: 'LocationCtrl'
      // })
      // .when('/events/:id/reviews', {
      //   templateUrl: 'views/event.html',
      //   // controller: 'index'
      // })
      // .when('/events/:id/media', {
      //   templateUrl: 'views/event.html',
      //   // controller: 'index'
      // })
      // .when('/events/:id/users', {
      //   templateUrl: 'views/event.html',
      //   // controller: 'index'
      // })
      // .when('/locations/:id/reviews', {
      //   templateUrl: 'views/event.html',
      //   // controller: 'index'
      // })
      // .when('/locations/:id/users', {
      //   templateUrl: 'views/event.html',
      //   // controller: 'index'
      // })
      // .when('/events/:id/media', {
      //   templateUrl: 'views/event.html',
      //   // controller: 'index'
      // })
      // .when('/users', {
      //   templateUrl: 'views/event.html',
      //   // controller: 'index'
      // })
      // .when('/users/:id', {
      //   templateUrl: 'views/my-profile.html',
      //   // controller: 'index'
      // })
      // .when('/users/:id/subscriptions', {
      //   templateUrl: 'views/event.html',
      //   // controller: 'index'
      // })
      // .when('/users/:id/reviews', {
      //   templateUrl: 'views/event.html',
      //   // controller: 'index'
      // })
      // .when('/users/:user_id/subscriptions/:subscribed_to', {
      //   templateUrl: 'views/event.html',
      //   // controller: 'index'
      // })
      // .when('/categories/:id/users', {
      //   templateUrl: 'views/event.html',
      //   // controller: 'index'
      // })
      .otherwise({
        // template: "This doesn't exist!"
        redirectTo: '/'
      })
  });
