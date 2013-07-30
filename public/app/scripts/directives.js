angular.module('partials', [])
    .directive("topNav", function () {
        return {
            restrict: 'E',
            template: '<nav id="top-nav">'+
                        '<ul>'+
                          '<li id="category"><a href="index.html#/category"><img src="img/list-grey.png" alt="">Category</a></li>'+
                          '<li id="friends"><a href=""><img src="img/friends-grey.png" alt="">Friends</a></li>'+
                          '<li id="location"><a href="location.html"><img src="img/map-grey.png" alt="">Location</a></li>'+
                        '</ul>'+
                      '</nav>',
            replace: true
        };
    });