class CurrentProject extends Service
    
    _current = undefined

    _listeners = {}

    constructor: ($rootScope, $q, modelLoaderService) ->
        @root = $rootScope
        @deferred = -> $q.defer()
        @loadModel = -> 
            modelLoaderService.load(_current.options, _current.dotPath, _current.modelPath)
        @reloadModel = -> 
            modelLoaderService.reload(_current.modelPath)

    set: (project) ->
        return if _current?.id is project.id
        _current = project
        @root.currentProject = project
        _current.whenModelReady = @getModelPromiseFor @reloadModel
        @trigger 'reset', _current
        
    refresh: ->
        _current.whenModelReady = @getModelPromiseFor @reloadModel
        @trigger 'refresh', _current
        
    save: ->
        _current.whenModelReady = @getModelPromiseFor @loadModel
        @trigger 'save', _current
        _current.save()

    # ---

    getModelPromiseFor: (method) ->
        d = @deferred()
        
        method()
            .then (model) -> d.resolve(model)
            .catch (err) -> d.reject(err)
    
        return d.promise 


    trigger: (event, data) ->
        listener(data) for listener in _listeners[event]

    'on': (events, fn) ->
        for event in events.split(',')
            _listeners[event] or= []
            _listeners[event].push fn 