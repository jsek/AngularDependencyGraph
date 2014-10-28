class CurrentProject extends Service
    
    _current = undefined

    _listeners = {}

    constructor: ($rootScope, $q, modelLoaderService) ->
        @root = $rootScope
        @deferred = -> $q.defer()
        @loadModel = -> 
            modelLoaderService.load(_current.options, _current.modelPath)

    set: (project) ->
        _current = project
        @root.currentProject = project
        @trigger 'reset', _current
        
    refresh: ->
        @trigger 'refresh', _current
        
    save: ->
        d = @deferred()
        
        @loadModel()
            .then (model) -> d.resolve(model)
            .catch (err) -> d.reject(err)
    
        _current.whenModelReady = d.promise 
        
        _current.save()
        
        @trigger 'reset', _current

    # ---

    trigger: (event, data) ->
        listener(data) for listener in _listeners[event]

    'on': (event, fn) ->
        _listeners[event] or= []
        _listeners[event].push fn 