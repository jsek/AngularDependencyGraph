class Intro extends Controller
    constructor: (mainViewService, newProjectService) ->

        newProject = ->
            newProjectService.show()             
        
        importProject = ->
            sweetAlert { title: '!' }

        mainViewService.set 'intro.jade', { title:"Angular Module Graph Generator" }

        mainViewService.find('.new-project').click newProject
        mainViewService.find('.import-project').click importProject
        
        console.log '>> [Intro] loaded'