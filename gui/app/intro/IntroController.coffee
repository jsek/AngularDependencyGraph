class Intro extends Controller
    constructor: (mainViewService, $scope) ->

        $scope.title = "Angular Module Graph Generator"
        $scope.newProject = -> mainViewService.set 'newProject.jade', $scope
        $scope.importProject = -> sweetAlert { title: '!' }

        mainViewService.set 'intro.jade', $scope

        console.log '>> [Intro] loaded'