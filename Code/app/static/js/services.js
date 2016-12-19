var hostname = document.location.host;

angular.module('myApp').factory('AuthService',
    ['$q', '$timeout', '$http', '$window',
        function ($q, $timeout, $http, $window) {


            function login(email, password) {

                // create a new instance of deferred
                var deferred = $q.defer();

                // send a post request to the server
                $http.post('http://127.0.0.1:5000/api/v1.0/login/', {email: email, password: password})
                // handle success
                    .success(function (data, status, headers, config) {
                        console.log("ok");
                        if (status === 200) {
                            $window.sessionStorage.token = data["token"];
                            $window.sessionStorage.setItem('id', data["id"]);
                            deferred.resolve();
                        } else {
                            deferred.reject();
                        }
                    })
                    // handle error
                    .error(function (data) {
                        deferred.reject();
                    });

                // return promise object
                return deferred.promise;

            }
        }]);