module.exports = (grunt) ->
    
    nodeunitReporter = if process.env.ANGULARDEPENDENCYGRAPH_COVERAGE then 'lcov' else 'default'

    all_coffeeScript = [
        'src/**/*.coffee'
        'tasks/**/*.coffee'
        'tests/**/*.coffee'
        'config/**/*.coffee'
        'Gruntfile.coffee'
        'Gulpfile.coffee'
    ]

    all_javaScript = all_coffeeScript
        .map (x) -> x.replace '.coffee', '.js' 

    all_coffeeScript_andViews = all_coffeeScript.concat ['gui/views/jade/**/*.jade']

    scripts_with_eval = [
        "src/**/parser.js"
        "Gruntfile.js"
    ]
    
    jshintOptions = 
        "-W030"     : true
        "eqnull"    : true
        "loopfunc"  : true
        "node"      : true

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
            options:
                bin: '../GraphViz/bin/'
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
                src: all_coffeeScript
                dest: '.'
                ext: '.js'
            
        coffeelint:
            all: all_coffeeScript
            options:
                configFile: 'coffeelint.json'

        nodeunit:
            options:
                reporter: nodeunitReporter
            files: ['tests/**/*Specs.js']

        watch:
            coffeescript: 
                files: all_coffeeScript_andViews
                tasks: [
                    'newer:coffeelint'
                    'newer:coffee'
                    'newer:jshint:all'
                ]

        jshint:
            all:
                options: do -> 
                    newOptions = Object.create jshintOptions
                    newOptions.ignores = scripts_with_eval.concat('tests/**/*_fixture.js')
                    newOptions

                files: 
                    src: all_javaScript

            withEval:
                options: do ->
                    newOptions = Object.create jshintOptions
                    newOptions['-W061'] = true
                    newOptions

                files: 
                    src: scripts_with_eval

        batch:
            options:
                cmd: (f) -> 
                    path = f.src[0].replace('/','\\')
                    c = "cmd /C \"#{process.cwd()}\\#{path}\""
                    console.log c
                    c

            gui:
                files:
                    src: ['gui/run.bat'],

    grunt.loadNpmTasks 'grunt-contrib-nodeunit'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-jshint'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-coffeelint'
    grunt.loadNpmTasks 'grunt-batch'
    grunt.loadNpmTasks 'grunt-newer'
    
    grunt.loadTasks 'tasks'

    grunt.registerTask 'default',   ['generate', 'graphviz']
    grunt.registerTask 'validate',  ['coffeelint', 'jshint']
    grunt.registerTask 'build',     ['coffee', 'validate']
    grunt.registerTask 'test',      ['nodeunit']
    grunt.registerTask 'run',       ['batch:gui']
