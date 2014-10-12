class RecentProjects extends Controller
    
    constructor: (mainViewService, $scope, projectListService, projectRepositoryService) ->
        
        $scope.projects = projectRepositoryService.getProjects()

        projectListService.on 'add', (project) ->
            $scope.projects.splice 0, 0, project