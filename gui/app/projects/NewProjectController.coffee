fs = require 'node-fs'

class NewProject extends Controller

    constructor: (mainViewService, $scope, $element, projectRepositoryService) ->
        
        $scope.createProject = (isValid) ->

            newProject = new Project($scope.newName)

            if fs.existsSync(newProject.modelPath) or fs.existsSync(newProject.configPath)
                sweetAlert
                    title: 'Cannot create project'
                    text: "Folder [#{newProject.path}] exists and could be overwritten.\nUse [Import] to open existing project."
                return
            
            mainViewService.set 'pages/intro.jade'
            # TODO: Navigate directly to the new project options

            projectRepositoryService.add newProject
            $scope.newName = ''

        $scope.goBack = ->
            mainViewService.back()

        console.log '>> [New Project] loaded'