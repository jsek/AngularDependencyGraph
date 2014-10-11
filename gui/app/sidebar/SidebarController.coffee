class Sidebar extends Controller
    
    constructor: (mainViewService, $scope, projectListService, projectNavigationService) ->
        
        # Dummy data
        $scope.projects = [
            { id: 1, name: 'Untitled1', path: 'C:\\Temp' }
            { id: 2, name: 'Demo', path: 'C:\\Documents\\Reports\\Demo' }
        ]

        mainViewService.on 'change', (filename) ->
            $scope.currentView = filename

        $scope.goHome = ->
            mainViewService.set 'intro.jade'

        projectListService.on 'add', (project) ->
            $scope.projects.push project

        $scope.open = (projectId) ->
            project = $scope.projects.find (x) -> x.id is projectId
            mainViewService.set 'projectContent.jade', $scope
            projectNavigationService.set project
            