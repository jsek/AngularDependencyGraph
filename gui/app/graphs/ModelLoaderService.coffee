fs = require 'node-fs'
exec = require('child_process').exec

class ModelLoader extends Service

    d = undefined # TODO: dirty
    
    ifNot = (err, next) ->
        if err?
            console.error err
            d.reject err
        else
            next()


    constructor: ($q) ->
        @deferred = -> $q.defer()

    reload: (filePath) ->
        
        d = @deferred()
        fs.readFile filePath, (err, data) ->
            ifNot err, ->
                d.resolve data.toString()

        return d.promise

    load: (options, dotPath, filePath) ->
        d = @deferred()

        _options = 
            colors: options.colors
            ignore: options.ignore
            json:   options.json

        _files = options.files ## or should it be string ?
        
        try
            gruntfile = """
            module.exports = function(grunt) {
                grunt.initConfig({
                    generate: {
                        options: #{JSON.stringify(_options)},
                        compile: {
                            files: { '#{filePath.pathInCode()}': ['#{_files.pathInCode()}'] }
                        }
                    }
                });

                grunt.loadTasks('tasks');
                grunt.registerTask('default', ['generate']);
            };

            """

            fs.writeFile 'gruntfile.js', gruntfile, (err) ->
                console.log gruntfile
                ifNot err, ->
                    exec 'node_modules\\.bin\\grunt.cmd', (err) ->
                        ifNot err, ->
                            text = fs.readFileSync(filePath).toString()
                            d.resolve text
                            console.log 'New model loaded successfully'
            
        catch err
            d.reject err

        return d.promise
