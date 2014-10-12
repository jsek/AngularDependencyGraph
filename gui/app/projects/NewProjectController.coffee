class NewProject extends Controller

    constructor: (mainViewService, $scope, $element, projectListService, fileDialog) ->
        
        projectPath = $element.find('.projectPath')
        onDirectoryChanged = (directory) -> projectPath.val(directory)

        # TODO: load last used directory        

        $scope.createProject = (isValid) ->
            mainViewService.set 'intro.jade'
            newProject = 
                name: $scope.project.name 
                path: $scope.project.path
            
            # TODO: Prompt if user tries any project files will be overwritten
            projectListService.add newProject
            $scope.project.name = ''

        $scope.goBack = -> 
            mainViewService.back()
        
        $scope.openDialog = ->
            fileDialog.openDir onDirectoryChanged

        console.log '>> [New Project] loaded'