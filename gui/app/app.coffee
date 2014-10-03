class App extends App
    constructor: ->
        return ['ngRoute', 'ui.bootstrap']

class AppConfig extends Config
    constructor:  ->

class Main extends Controller
    constructor: ($scope, $rootScope) ->
        $scope.test = 'World - Test'
        $rootScope.test = 'World - Root'
