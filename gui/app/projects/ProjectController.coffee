class Project extends Controller
    
    constructor: ($scope, projectNavigationService) ->
        
        $scope.project = {}

        projectNavigationService.on 'change', (project)->
            $scope.project = project