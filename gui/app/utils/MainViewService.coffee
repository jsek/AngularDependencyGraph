fs = require 'node-fs'
jade = require 'jade'

class MainView extends Service

    _history = []
    _templates = []
    _wasAlreadySet = false
    _shadowDOM = $('<div>')
    
    constructor: ->
        @main = $('.main')
        _shadowDOM.insertBefore(@main).hide()
                
    set: (filename, data, ignoreHistory = false) ->

        _history.push(filename) unless ignoreHistory

        if _templates[filename]?
            @main.children().detach().appendTo _shadowDOM
            _shadowDOM.children("[data-template='#{filename}']").detach().appendTo @main
            _wasAlreadySet = true
        else
            template = jade.compile fs.readFileSync("gui/views/#{filename}")
            compiledHTML = template data
            
            newContent = $("<div data-template='#{filename}'></div>")
            newContent.html compiledHTML

            @main.children().detach().appendTo _shadowDOM
            @main.append newContent

            _templates[filename] = newContent
            _wasAlreadySet = false

        
    find: (selector) ->
        @main.find selector

    wasAlreadySet: -> _wasAlreadySet
        
    back: ->
        _history.pop()
        @set _history.last(), null, true
