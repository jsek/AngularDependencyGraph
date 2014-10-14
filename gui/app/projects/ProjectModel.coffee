
class ProjectOptions
    
    _defaults = 
        files: []
        showEmptyItems: false
        verbose: false
        colors:
            externalDependencies: 'red'
        ignore: []
        rootModule: undefined
        levelLimit: 
            above: undefined
            below: undefined

    constructor: (options) ->
        
        for key, value in _defaults
            @[key] = options[key] || _defaults[key]
    

class Project

    __id = 1
    _modelFilename = 'model.dot'
    _configFilename = 'model.config'
    
    constructor: (@name, @path, options) ->
        @id = __id++
        @options = new ProjectOptions(options)
        @modelPath = @path + _modelFilename
        @configPath = @path + _configFilename
