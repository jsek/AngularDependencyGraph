fs = require 'node-fs'
jade = require 'jade'
exec = require('child_process').exec
grunt = '.\\node_modules\\.bin\\grunt.cmd'

class ProjectOptions extends Controller
    
    constructor: ($scope, $element, mainViewService, currentProjectService, fileDialog) ->

        _projectFiles = $element.find('.js-projectFiles')

        $scope.refresh = ->
            currentProjectService.refresh()

        currentProjectService.on 'reset', (project) ->
            $scope.options = project.options
            console.log ">> [Project View](#{project.id}) loaded"

        onDirectorySelected = (directory) ->
            comma = _projectFiles.val().length is 0 ? ',\n' : ''
            _projectFiles.val _projectFiles.val() + comma + "#{directory}\\**\\*.js"
            $scope.$apply()

        $scope.openDialog = ->
            fileDialog.openDir onDirectorySelected

        $scope.save = ->
            $scope.visible = false
            # TODO

        $scope.hide = ->
            $scope.visible = false