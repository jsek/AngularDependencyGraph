fs = require 'node-fs'

class Project extends Controller
    
    constructor: ($scope, projectNavigationService) ->
        
        $scope.project = {}

        projectNavigationService.on 'change', (project)->
            $scope.project = project

            dotFilePath = project.path + 'model.dot'
            if fs.existsSync(dotFilePath)
                $scope.dotFile = fs.readFileSync(dotFilePath).toString()
            else $scope.dotFile = null