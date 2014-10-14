class RecentProjects extends Controller
    
    constructor: (mainViewService, $scope, projectListService, projectRepositoryService, projectNavigationService) ->
        
        $scope.projects = projectRepositoryService.getProjects()

        projectListService.on 'add', (project) ->
            $scope.projects.splice 0, 0, project

        $scope.open = (projectId) ->
            project = $scope.projects.find (x) -> x.id is projectId
            mainViewService.set 'projectContent.jade', $scope
            projectNavigationService.set project
            
        console.log '>> [Recent Projects] loaded'