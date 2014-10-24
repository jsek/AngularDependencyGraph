
class Project

    _homeDir = process.env['USERPROFILE']

    _projects = "#{_homeDir}\\AngularDependencyGraph\\Projects\\"


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

    constructor: (options = {}) ->
        
        for key, value of _defaults
            @[key] = options[key] || _defaults[key]
