jade = require 'jade'

class MainView extends Service

    _history = []
    _templates = []
    _wasAlreadySet = false
    _shadowDOM = $('<div>')
    
    _compilator = {}

    _listeners = {}

    viewsRootDirectory = 'gui/views/'
    
    constructor: ($compile, $rootScope) ->
        _compilator = $compile
        @container = $('.main')
        @sidebar = $('.sidebar')
        _shadowDOM.insertBefore(@container).hide()
        @defaultScope = $rootScope
                
    set: (filename, $scope, ignoreHistory = false) ->

        _history.push(filename) unless ignoreHistory

        @currentTemplate = filename

        @trigger 'change', filename

        if _templates[filename]?
            @container.children().detach().appendTo _shadowDOM
            _shadowDOM.children("[data-template='#{filename}']").detach().appendTo @container
            _wasAlreadySet = true
        else
            template = jade.compileFile(viewsRootDirectory + filename)
            compiledHTML = _compilator(template())($scope or @defaultScope)
            
            newContent = $("<div data-template='#{filename}'></div>")
            newContent.html compiledHTML

            @container.children().detach().appendTo _shadowDOM
            @container.append newContent

            _templates[filename] = newContent
            _wasAlreadySet = false

    find: (selector) ->
        @container.find selector

    wasAlreadySet: -> _wasAlreadySet
        
    back: ->
        _history.pop()
        @set _history.last(), null, true

    expand: ->
        @sidebar.addClass 'slide-out'
        @container.addClass 'expanded'
    
    collapse: ->
        @sidebar.removeClass 'slide-out'
        @container.removeClass 'expanded'

    trigger: (event, data) ->
        listener(data) for listener in _listeners[event]

    'on': (events, fn) ->
        for event in events.split(',')
            _listeners[event] or= []
            _listeners[event].push fn 
