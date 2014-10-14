fs = require 'node-fs'
exec = require('child_process').exec

class ProjectView extends Controller
    
    constructor: ($scope, $element, mainViewService, projectNavigationService) ->
        
        $scope.project = {}
        $scope.model = { visible: false }
        $scope.options = { visible: true }
        $scope.notes = { visible: false }

        _projectModel = $element.find('.projectModel')

        $scope.toggleOptions = ->
            $scope.options.visible = not $scope.options.visible

        $scope.toggleNotes = ->
            $scope.notes.visible = not $scope.notes.visible

        $scope.saveOptions = ->
            $scope.options.visible = false
            $scope.refresh()

        $scope.refresh = ->

            sources = JSON.parse($scope.options.files).map((x) -> "#{$scope.project.path}#{x}".replace(/\\/g,'/'))
            sources = JSON.stringify(sources).replace(/"/g,'\'')
            dotFile = $scope.project.modelPath.replace(/\\/g,'/')
            
            gruntfile = """
            module.exports = (grunt) ->
                grunt.initConfig
                    generate:
                        options: 
                            showEmptyItems: false
                            verbose: true
                            colors: { externalDependencies: 'red' }
                            ignore: ['$*', 'ng*']
                        compile:
                            files: 
                                '#{dotFile}': #{sources}

                grunt.loadTasks 'tasks'
                grunt.registerTask 'default', ['generate']            
            
            """
            fs.writeFileSync('.\\Gruntfile.coffee', gruntfile)
            child = exec '.\\node_modules\\.bin\\grunt.cmd --no-color', (error, stdout, stderr) ->
                console.log "refresh[#{$scope.project.id}]: #{stdout}"
                console.log "exec error: #{error}"  if error?
                
                if fs.existsSync($scope.project.modelPath)
                    $scope.dotFile = fs.readFileSync($scope.project.modelPath).toString()
                else 
                    $scope.dotFile = 'Cannot load "model.dot"'

                $scope.$apply()

            $scope.model.visible = true        
            $scope.dotFile = 'Loading...'

        $scope.expand = ->
            $scope.options.visible = false
            mainViewService.expand()
            $scope.expanded = true

        $scope.collapse = ->
            mainViewService.collapse()
            $scope.expanded = false

        projectNavigationService.on 'change', (project) ->
            
            $scope.project = project
            $scope.options = project.options

            if fs.existsSync(project.modelPath)
                $scope.dotFile = fs.readFileSync(project.modelPath).toString()
            else 
                $scope.dotFile = null

            console.log ">> [Project View](#{project.id}) loaded"