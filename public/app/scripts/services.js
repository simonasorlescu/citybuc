angular.module('eventsService', ['ngResource'])
  .factory('Events', function($resource) {
    return $resource('/events.json', {}, {
      index: { method: 'GET', isArray: true }
    });
  })
  .factory('Event', function($resource) {
    return $resource('/events/:event_id.json', {}, {
      show: { method: 'GET', params:{event_id:'events'}, isArray:true }
    });
  })
  // .factory('Locations', function($resource) {
  //   return $resource('/locations.json', {}, {
  //     index: { method: 'GET', isArray: true }
  //   });
  // })
  // .factory('Location', function($resource) {
  //   return $resource('/locations/:location_id.json', {}, {
  //     show: { method: 'GET', params:{location_id:'locations'}, isArray:true }
  //   });
  // })
  // .factory('Users', function($resource) {
  //   return $resource('/users.json', {}, {
  //     index: { method: 'GET', isArray: true }
  //     create: { method: 'POST' }
  //   });
  // })
  // .factory('User', function($resource) {
  //   return $resource('/users/:user_id.json', {}, {
  //     show: { method: 'GET', params:{user_id:'users'}, isArray:true }
  //     update: { method: 'PUT' }
  //     destroy: { method: 'DELETE' }
  //   });
  // })
  // .factory('Categories', function($resource) {
  //   return $resource('/categories.json', {}, {
  //     index: { method: 'GET', isArray: true }
  //   });
  // })
  // .factory('Media', function($resource) {
  //   return $resource('/media.json', {}, {
  //     index: { method: 'GET', isArray: true }
  //   });
  // })
  // .factory('Medium', function($resource) {
  //   return $resource('/media/:medium_id.json', {}, {
  //     show: { method: 'GET', params:{medium_id:'media'}, isArray:true }
  //   });
  // })
  // .factory('Reviews', function($resource) {
  //   return $resource('/reviews.json', {}, {
  //     index: { method: 'GET', isArray: true }
  //     create: { method: 'POST' }
  //   });
  // })
  // .factory('Review', function($resource) {
  //   return $resource('/reviews/:review_id.json', {}, {
  //     show: { method: 'GET', params:{review_id:'reviews'}, isArray:true }
  //     update: { method: 'PUT' }
  //     destroy: { method: 'DELETE' }
  //   });
  // })
  // .factory('Subscriptions', function($resource) {
  //   return $resource('/subscriptions.json', {}, {
  //     index: { method: 'GET', isArray: true }
  //     create: { method: 'POST' }
  //   });
  // })
  // .factory('subscription', function($resource) {
  //   return $resource('/subscriptions/:subscription_id.json', {}, {
  //     show: { method: 'GET', params:{subscription_id:'subscriptions'}, isArray:true }
  //     destroy: { method: 'DELETE' }
  //   });
  // })