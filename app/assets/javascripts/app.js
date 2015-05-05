(function() {
  var app = angular.module('comunidad', ["ngResource", 'ngRoute']);

  /*app.config(function($routeProvider) {
    $routeProvider
        .when('/panel', {
            templateUrl: '/panel.html'
        })
        .when('/', {
            templateUrl: '/index.html'
        })
        ;
  });
  */

  app.controller("WelcomeController", function($scope, $resource, $routeParams, $location) {
    var AllUserGames = $resource("/user_games.json", {}, {});
    $scope.current_user_games = [];
    $scope.tab = 2;
    $scope.not_adding_game = true;
    $scope.adding_game = false;

    $scope.selectTab = function(tab){
      $scope.tab = tab;
    };

    $scope.isSelectedTab = function(tab){
      return $scope.tab === tab;
    };

    $scope.startAddingGame = function(){
      $scope.not_adding_game = false;
      $scope.adding_game = true;
    }

    $scope.getAllUserGames = function(){
      AllUserGames.get().$promise.then(
        function( value ){
          console.log(value);
          $scope.current_user_games = value.current_user_games;
        },
        function( error ){/*Do something with error*/}
      );
    };


    $scope.activeWindow = function(){
      if ($location.path() === "/"){
        $scope.dashboard_style = "active";
        $scope.profile_style = "";
      }else if ($location.path() === "/panel"){
        $scope.getAllProducts();
        $scope.profile_style = "active";
        $scope.dashboard_style = "";
      };
    };

    $scope.getAllUserGames();
    $scope.activeWindow();
  });

})();
