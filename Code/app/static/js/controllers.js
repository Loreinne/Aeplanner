angular.module('myApp').controller('userController',
    ['$scope', '$location', '$window','AuthService',
        function ($scope, $location ,$window, AuthService) {
             $scope.isAuthenticated = false;
                $scope.login = function () {

                    // initial values
                    $scope.error = false;
                    $scope.disabled = true;

                    // call login from service
                    AuthService.login($scope.loginForm.email_address, $scope.loginForm.password)
                    // handle success
                        .then(function (res) {
                            $window.location.href = "dashboard.html#/dashboard"
                            $scope.isAuthenticated = true;
                            $scope.disabled = false;
                            $scope.loginForm = {};
                        })
                        // handle error
                        .catch(function () {
                            delete $window.sessionStorage.token;
                            $scope.isAuthenticated = false;
                            $scope.error = true;
                            $scope.errorMessage = "Invalid username and/or password";
                            $scope.disabled = false;
                            $scope.loginForm = {};
                        });
                };

                $scope.logout = function () {
                    $scope.isAuthenticated = false;
                    delete $window.sessionStorage.token;
                    delete $window.sessionStorage.id;
                    $window.location.href = "index.html";
                };
                $scope.register = function () {

                    // initial values
                    $scope.error = false;
                    $scope.disabled = true;

                    // call register from service
                    AuthService.register(
                        $scope.registerForm.email_address,
                        $scope.registerForm.fname,
                        $scope.registerForm.lname,
                        $scope.registerForm.password,
                        $scope.registerForm.address,
                        $scope.registerForm.birthdate,
                        $scope.registerForm.age)

                    // handle success
                        .then(function () {
                            $location.path('/login');
                            $scope.disabled = false;
                            $scope.registerForm = {};
                        })
                        // handle error
                        .catch(function () {
                            $scope.error = true;
                            $scope.errorMessage = "Something went wrong!";
                            $scope.disabled = false;
                            $scope.registerForm = {};
                        });

                };
            }]);

