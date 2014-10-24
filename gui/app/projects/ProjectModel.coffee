

_homeDir = process.env[(process.platform is 'win32') ? 'USERPROFILE' : 'HOME']
_projects = "#{_homeDir}\\AngularDependencyGraph\\Projects\\"

class Project

    __id = 1
    _modelFilename = 'model.dot'
    _configFilename = 'model.config'

    constructor: (@name, options) ->
        @id = __id++
        @path = _projects + @name
        @options = new Options(options)
        @modelPath = @path + _modelFilename
        @configPath = @path + _configFilename

class Options
    
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
    
