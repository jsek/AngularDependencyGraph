class NewProject extends Controller
    constructor: (mainViewService, $scope, projectListService) ->

        $scope.createProject = (isValid) ->
            mainViewService.set 'intro.jade'
            newProject = 
                name: $scope.project.name 
                path: $scope.project.path
            
            projectListService.add newProject
            $scope.project.name = ''

        $scope.goBack = -> mainViewService.back()

        console.log '>> [New Project] loaded'