class Sidebar extends Controller
    
    constructor: (mainViewService, $scope, projectListService, currentProjectService, projectRepositoryService) ->
        
        $scope.projects = projectRepositoryService.getProjects()

        mainViewService.on 'change', (filename) ->
            $scope.currentView = filename

        $scope.goHome = ->
            mainViewService.set 'pages/intro.jade'

        projectListService.on 'add', (project) ->
            $scope.projects.push project

        $scope.open = (projectId) ->
            project = $scope.projects.find (x) -> x.id is projectId
            mainViewService.set 'pages/project.jade'
            currentProjectService.set project
            
        console.log '>> [Sidebar] loaded'