fs = require 'node-fs'

class Project extends Controller
    
    constructor: ($scope, projectNavigationService) ->
        
        $scope.project = {}

        projectNavigationService.on 'change', (project)->
            $scope.project = project

            dir = project.path + (if project.path[project.path.length - 1] isnt '\\' then '\\' else '')

            dotFilePath = dir + 'model.dot'
            if fs.existsSync(dotFilePath)
                $scope.dotFile = fs.readFileSync(dotFilePath).toString()
            else $scope.dotFile = null

            svgFilePath = dir + 'model.svg'
            if fs.existsSync(svgFilePath)
                $scope.svgFilePath = svgFilePath
            else $scope.svgFilePath = '../resources/model.png'
