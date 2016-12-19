myApp.config(function ($stateProvider, $urlRouterProvider) {

  $urlRouterProvider.otherwise("/404");

  $stateProvider

      .state('landingpage', {
          url: "",
          templateUrl: "partials/landingpage.html",
          controller: 'searchController'
      })

    });

myApp.run(['$window', '$rootScope',
function ($window ,  $rootScope) {
  $rootScope.goBack = function(){
    $window.history.back();
  }
}]);