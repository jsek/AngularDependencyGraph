fs = require 'node-fs'

class NewProject extends Controller

    constructor: (mainViewService, $scope, $element, projectListService, fileDialog) ->
        
        projectPath = $element.find('.projectPath')
        onDirectoryChanged = (directory) -> projectPath.val(directory)

        # TODO: load last used directory

        $scope.createProject = (isValid) ->

            dir = $scope.project.path
            dir = dir + (if dir[dir.length - 1] isnt '\\' then '\\' else '')

            newProject = new Project($scope.project.name, dir)

            if fs.existsSync(newProject.modelPath) or fs.existsSync(newProject.configPath)
                sweetAlert
                    title: 'Cannot create project'
                    text: 'Some files would be overwritten, use [Import] to open existing project'
                return
            
            mainViewService.set 'intro.jade'

            projectListService.add newProject
            $scope.project.name = ''

        $scope.goBack = ->
            mainViewService.back()
        
        $scope.openDialog = ->
            fileDialog.openDir onDirectoryChanged

        console.log '>> [New Project] loaded'