fs = require('node-fs')

class Project
    __id = 1
    _modelFilename = 'model.dot'
    _configFilename = 'model.config'

    constructor: (@name, options) ->
        @id = __id++
        @path = global.projectsDir + @name
        @options = new Options(options)
        @modelPath = @path + '\\' + _modelFilename
        @configPath = @path + '\\' + _configFilename
        
        unless fs.existsSync @path
            @createProjectDir()
        else
            @loadOptions()         
    
    save: ->
        fs.writeFile @configPath, JSON.stringify @options
        
    createProjectDir: ->
        fs.mkdir @path, (err) =>
            if err?
                sweetalert
                    title: 'Warning'
                    text: "We cannot create project directory (#{@path})"
                    type: 'error'
            else
                @save()
                
    loadOptions: ->
        if fs.existsSync @configPath
            optionsText = fs.readFileSync @configPath
            @options = new Options(JSON.parse optionsText.toString())


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
