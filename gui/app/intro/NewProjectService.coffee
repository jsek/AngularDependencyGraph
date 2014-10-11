class NewProject extends Service
    constructor: (mainViewService) ->
        @mainView = mainViewService
    
    init: ->
    
        createProject = ->
            sweetAlert { title: '!' }
        
        goBack = =>
            @mainView.back()


        @mainView.find('.create-project').click createProject
        @mainView.find('.cancel').click goBack
        
        console.log '>> [New Project] loaded'
    
    show: ->
        
        @mainView.set 'newProject.jade'
        
        if @mainView.wasAlreadySet()
            # TODO: reset project name
            console.log '>> [New Project] reloaded'
        else
            @init()
