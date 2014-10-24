class Search extends Controller
    constructor: ($scope, $element) ->
        
        Placeholdem($element.find('[placeholder]'))

        $scope.expand = ->
            $scope.expanded = true

        $scope.collapse = ->
            $scope.expanded = false
