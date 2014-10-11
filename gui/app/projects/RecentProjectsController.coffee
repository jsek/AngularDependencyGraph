class RecentProjects extends Controller
    
    constructor: (mainViewService, $scope, projectListService) ->
        
        # TODO: Load from central repo
        $scope.projects = [
            { id: 1, name: 'Untitled1', path: 'C:\\Temp' }
            { id: 2, name: 'Demo', path: 'C:\\Documents\\Reports\\Demo' }
        ]

        projectListService.on 'add', (project) ->
            $scope.projects.splice 0, 0, project