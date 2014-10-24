class ProjectControlPanel extends Controller
    
    constructor: ($scope, $rootScope, mainViewService) ->
        $scope.project = {}
        $scope.model = { visible: false }
        $scope.options = { visible: true }
        $scope.notes = { visible: false }

        $scope.toggleOptions = ->
            $rootScope.optionsVisible = not $rootScope.optionsVisible

        $scope.toggleNotes = ->
            $rootScope.notesVisible = not $rootScope.notesVisible

        $scope.expand = ->
            $scope.options.visible = false
            mainViewService.expand()
            $scope.expanded = true

        $scope.collapse = ->
            mainViewService.collapse()
            $scope.expanded = false