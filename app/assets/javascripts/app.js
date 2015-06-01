(function() {
  var app = angular.module('comunidad', ["ngResource", 'ngRoute', 'ngAnimate', 'ng-rails-csrf', 'flash']);

  app.config(function($routeProvider) {
    $routeProvider
        .when('/', {
          templateUrl: '/index.html'
        })
        .when('/games/:id', {
          templateUrl: '/gameview.html'
        })
        ;
  });

  app.controller("WelcomeController", function($scope, $resource, $routeParams, $location, Flash) {
    var OwnedGames = $resource("/ownedgames.json", {}, {});
    var AllGames = $resource("/games/index.json", {}, {});
    var GameComments = $resource("/game_comments.json", {}, {});
    $scope.current_owned_games = [];
    $scope.ownedgames_ids = [];
    $scope.games = [];
    $scope.game_comments = [];
    $scope.tab = 2;
    $scope.not_adding_game = true;
    $scope.adding_game = false;
    $scope.game_owned = false;
    $scope.checked = true;
    $scope.games_loaded = false;
    $scope.adding = "not_adding";
    $scope.focus = false;
    $scope.games_loading = false;
    $scope.current_game_id = null;

    $scope.changeView = function(view){
      $location.path(view);
    };

    $scope.isGameOwned = function(game_id){
      return $scope.ownedgames_ids.indexOf(game_id) > -1
    };

    $scope.saveOwnedGame = function(game){
      var ownedgame = new OwnedGames();
      ownedgame.game_id = game.id;
      ownedgame.formato = "Fisico";
      ownedgame.$save().then(
        function( value ){
          $scope.getAllOwnedGames();
          $scope.get_game($routeParams.id);
          Flash.create('success', "Juego Agregado", 'success');
        },
        function( error ){
          alert("Parece que ya agregaste este juego a tu libreria");
        }
      );
    };

    $scope.getGameComments = function(game_id){
      GameComments.get({ game_id:game_id }).$promise.then(
        function( value ){
          $scope.game_comments = value.game_comments;
        },
        function( error ){/*Do something with error*/}
      );
    }

    $scope.saveGameComment = function(game){
      var game_comment = new GameComments();
      game_comment.game_id = game.id;
      game_comment.content = this.content;
      game_comment.$save().then(
        function( value ){
          $scope.getGameComments(game.id);
          $scope.content = "";
        },
        function( error ){
          alert("Parece que ya agregaste este comentario a este juego");
        }
      );
    }

    $scope.selectTab = function(tab){
      $scope.tab = tab;
    };

    $scope.isSelectedTab = function(tab){
      return $scope.tab === tab;
    };

    $scope.stopAddingGame = function(){
      $scope.not_adding_game = true;
      $scope.adding_game = false;
      $scope.adding = "not_adding";
    };

    $scope.getAllOwnedGames = function(){
      OwnedGames.get().$promise.then(
        function( value ){
          $scope.current_owned_games = value.current_owned_games;
          $scope.ownedgames_ids = value.ownedgames_ids;
        },
        function( error ){/*Do something with error*/}
      );
    };

    var OwnedGame = $resource('/ownedgames/:id', {id: "@id"} , {"update": {method: "PUT"}});

    $scope.delete = function(game, ownedgame_id, idx){
      var r = confirm("Estás seguro que deseas eliminar a " + game.title + " de tu libreria de juegos?");
      if (r == true){
        OwnedGame.remove({ id:ownedgame_id }).$promise.then(
          //success
          function( value ){
            $scope.getAllOwnedGames();
            $scope.get_game($routeParams.id);
            Flash.create('danger', "Juego Eliminado", 'success');
          },
          //error
          function( error ){/*Do something with error*/}
        );
      }
    };

    var Game = $resource("/games/:id.json", {id: "@id"}, {});

    $scope.get_game = function(game_id, oid){
      Game.get({id:game_id}).$promise.then(
        function( value ){
          $scope.game = value.game;
          $scope.getGameComments(game_id);
          $scope.ownedgame_id = oid;
          $scope.changeView('/games/' + game_id);
          $scope.game_loaded = true;
        },
        function( error ){/*Do something with error*/}
      );
    };

    $scope.getAllGames = function(){
      $scope.games_loading = true;
      if($scope.games_loaded){
        $scope.adding_game = true;
        $scope.not_adding_game = false;
        $scope.adding = "adding";
        $scope.focus = true;
        $scope.games_loading = false;
      }else{
        AllGames.get().$promise.then(
          function( value ){
            $scope.games_loading = false;
            $scope.games_loaded = true;
            $scope.games = value.games;
            $scope.adding_game = true;
            $scope.not_adding_game = false;
            $scope.adding = "adding";
            $scope.focus = true;
          },
          function( error ){/*Do something with error*/}
        );
      }

    };


    $scope.activeWindow = function(){
      if ($location.path() === "/"){
        $scope.dashboard_style = "active";
        $scope.profile_style = "";
      }else if ($location.path() === "/games/" + $routeParams.id && !$scope.game_loaded){
        $scope.get_game($routeParams.id);
      };
    };

    $scope.getAllOwnedGames();
    $scope.activeWindow();
  });

})();
