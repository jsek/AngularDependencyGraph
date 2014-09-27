﻿module.exports = (grunt) ->
    grunt.initConfig

        generate:
            options:
                showEmptyItems: false
                verbose: true
                colors: 
                    externalDependencies: "red"
                ignore: ["$*", "ng*"]
                #rootModule: "Module3"
                #levelLimit: { above: 2, below: 3 }

            compile:
                files:
                    "./examples/simple.dot": ["./examples/simple/**/*.js"]
                    "./examples/complex.dot": ["./examples/complex/**/*.js"]

        graphviz:
            compile:
                files:
                    "./examples/simple.svg": "./examples/simple.dot"
                    "./examples/complex.png": "./examples/complex.dot"
                    "./examples/complex.svg": "./examples/complex.dot"
        
        coffee:
            all:
                expand: true
                bare: true
                cwd: '.'
                src: ['src/**/*.coffee', 'tasks/**/*.coffee', 'tests/**/*.coffee', 'config/**/*.coffee', 'Gruntfile.coffee']
                dest: '.'
                ext: '.js'
            
        coffeelint:
            all: ['src/**/*.coffee', 'tasks/**/*.coffee', 'tests/**/*.coffee', 'config/**/*.coffee']
            options:
                configFile: 'coffeelint.json'
      
        nodeunit:
            options:
                reporter: 'default'
            files: ['tests/**/*Specs.js']

        watch:
            coffeescript: 
                files: ['**/*.coffee'],
                tasks: ['newer:coffeelint','newer:coffee']
                    

    grunt.loadNpmTasks 'grunt-contrib-nodeunit'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-coffeelint'
    grunt.loadNpmTasks 'grunt-newer'
    
    grunt.loadTasks 'tasks'

    grunt.registerTask 'default', ['generate', 'graphviz']
    grunt.registerTask 'build', ['coffeelint', 'coffee']
    grunt.registerTask 'test', ['nodeunit']