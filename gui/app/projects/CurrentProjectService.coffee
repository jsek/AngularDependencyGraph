﻿class CurrentProject extends Service
    
    _current = undefined

    _listeners = {}

    constructor: () ->
        
    set: (project) ->
        _current = project
        @trigger 'reset', _current
        
    refresh: ->
        @trigger 'refresh', _current

    trigger: (event, data) ->
        listener(data) for listener in _listeners[event]

    'on': (event, fn) ->
        _listeners[event] or= []
        _listeners[event].push fn 