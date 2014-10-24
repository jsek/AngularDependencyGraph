fs = require 'node-fs'
exec = require('child_process').exec

class ModelLoader extends Service

    constructor: ($q) ->
        @deferred = -> $q.defer()

    load: (options, projectDir) ->
        d = @deferred()

        ifNot = (err, next) ->
            if err
                d.reject err
            else

        _options = 
            colors: options.colors
            ignore: options.ignore

        _files = options.files ## or should it be string ?
        
        #try
        gruntfile = """
        module.exports = function(grunt) {
            grunt.initConfig({
                generate: {
                options: #{JSON.stringify(_options)},
                compile: {
                    files: {
                    '#{projectDir}': #{JSON.stringify(_files)}
                    }
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
                exec 'cmd /c "node_modules/.bin/grunt.cmd"', (err) ->
                    ifNot err, ->
                        d.resolve()
                        console.log 'New model loaded successfully'
            
        #catch err
        #    d.reject err

        return d.promise
