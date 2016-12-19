var myApp = angular.module('myApp', ['ui.router']);
myApp.config(function ($stateProvider, $urlRouterProvider) {

  $urlRouterProvider.otherwise("/404");

  $stateProvider

      .state('login', {
          url: "/login",
          templateUrl: "partials/login.html",
          controller: 'userController'
      })
     .state('signup', {
          url: "/signup",
          templateUrl: "partials/signup.html",
          controller: 'userController'
      })

    });

myApp.run(['$window', '$rootScope',
function ($window ,  $rootScope) {
  $rootScope.goBack = function(){
    $window.history.back();
  }
}]);