fs = require 'node-fs'
jade = require 'jade'

class MainView extends Service

    _history = []
    _templates = []
    _wasAlreadySet = false
    _shadowDOM = $('<div>')
    
    _compilator = {}

    _listeners = {}
    
    constructor: ($compile) ->
        _compilator = $compile
        @container = $('.main')
        @sidebar = $('.sidebar')
        _shadowDOM.insertBefore(@container).hide()
                
    set: (filename, $scope, ignoreHistory = false) ->

        _history.push(filename) unless ignoreHistory

        @trigger 'change', filename

        if _templates[filename]?
            @container.children().detach().appendTo _shadowDOM
            _shadowDOM.children("[data-template='#{filename}']").detach().appendTo @container
            _wasAlreadySet = true
        else
            template = jade.compile fs.readFileSync("gui/views/#{filename}")
            compiledHTML = _compilator(template())($scope)
            
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

    'on': (event, fn) ->
        _listeners[event] or= []
        _listeners[event].push fn 
