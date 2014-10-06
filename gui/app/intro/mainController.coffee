class Main extends Controller
    constructor: ($scope, $rootScope) ->
        $scope.test = 'Scope:Test'
        $rootScope.test = 'World - Root'
