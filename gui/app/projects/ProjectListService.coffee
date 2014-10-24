﻿class ProjectList extends Service
    _projects = []
    _listeners = {}
    
    constructor: () ->
        
    add: (project) ->
        _projects.push project
        @trigger 'add', project

    trigger: (event, data) ->
        listener(data) for listener in _listeners[event]

    'on': (event, fn) ->
        _listeners[event] or= []
        _listeners[event].push fn 