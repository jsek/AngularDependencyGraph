class Intro extends Controller
    constructor: (mainViewService, $scope) ->

        $scope.title = "Angular Module Graph Generator"
        $scope.newProject = -> mainViewService.set 'pages/newProject.jade'
        $scope.importProject = -> sweetAlert { title: '!' }

        mainViewService.set 'pages/intro.jade', $scope

        console.log '>> [Intro] loaded'