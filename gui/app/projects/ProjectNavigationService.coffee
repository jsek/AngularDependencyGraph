class ProjectNavigation extends Service
    _listeners = {}
    _currentProjectId = undefined
    _currentProject = undefined

    constructor: ($rootScope) ->
        @root = $rootScope
    
    set: (project) ->
        return if _currentProjectId is project.id
        
        _currentProjectId = project.id
        @root.currentProject = project
        @trigger 'change', project

    trigger: (event, data) ->
        listener(data) for listener in _listeners[event]

    'on': (event, fn) ->
        _listeners[event] or= []
        _listeners[event].push fn 