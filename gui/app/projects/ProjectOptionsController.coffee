class ProjectOptions extends Controller
    
    constructor: ($scope, $rootScope, $element, currentProjectService, fileDialog) ->

        _projectFiles = $element.find('.js-projectFiles')

        $scope.refresh = ->
            currentProjectService.refresh()

        currentProjectService.on 'reset', (project) ->
            $scope.options = project.options
            console.log ">> [Project View](#{project.id}) loaded"

        onDirectorySelected = (directory) ->
            $scope.options.files = "#{directory}\\**\\*.js"
            $scope.$apply()

        $scope.openDialog = ->
            fileDialog.openDir onDirectorySelected

        $scope.save = ->
            $rootScope.optionsVisible = false
            
            currentProjectService.save()
            # TODO

        $scope.hide = ->
            $rootScope.optionsVisible = false