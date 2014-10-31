class ProjectOptions extends Controller
    
    constructor: ($scope, $rootScope, $element, currentProjectService, fileDialog) ->

        _projectFiles = $element.find('.js-projectFiles')
        
        _hide = -> $rootScope.optionsVisible = false

        $scope.hide = _hide

        $scope.refresh = ->
            currentProjectService.refresh()

        currentProjectService.on 'reset', (project) ->
            $scope.options = project.options
            $scope.options.ignore_text = $scope.options.ignore.join(',')
            console.log ">> [Project View](#{project.id}) loaded"

        onDirectorySelected = (directory) ->
            $scope.options.files = "#{directory}\\**\\*.js"
            $scope.$apply()

        $scope.openDialog = ->
            fileDialog.openDir onDirectorySelected

        $scope.save = ->
            $scope.options.ignore = $scope.options.ignore_text.split(',')
            currentProjectService.save()
            _hide()