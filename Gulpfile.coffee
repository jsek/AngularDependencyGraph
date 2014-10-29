gulp        = require 'gulp'
gutil       = require 'gulp-util'
shell       = require 'gulp-shell'
coffee      = require 'gulp-coffee'
ngAnnotate  = require 'gulp-ng-annotate'
uglify      = require 'gulp-uglify'
ngClassify  = require 'gulp-ng-classify'
sass        = require 'gulp-ruby-sass'
jade        = require 'gulp-jade'
copy        = require 'gulp-copy'
NwBuilder   = require 'node-webkit-builder'


artefacts = [
    'gui/dist/**'
    'gui/resources/**'
    'gui/vendor/**'
    'gui/views/**'
    'package.json'
    'src/**'
    'tasks/**'
    'node_modules/jade/**'
    'node_modules/node-fs/**'
    'node_modules/grunt/**'
    'node_modules/grunt-cli/**'
    'node_modules/d3/**'
    'node_modules/dagre/**'
    'node_modules/dagre-d3/**'
    'node_modules/graphlib/**'
    'node_modules/lodash/**'
    'node_modules/.bin/grunt.cmd'
]


#///////////////////////////
#// Configurable pipes
#//

compileCoffee = (action) ->
    action or= gulp.src
    action 'gui/app/**/*.coffee'
        .pipe ngClassify (file) ->
            if file.path.indexOf('admin') isnt -1  # use 'admin' as the appName if 'admin' is found in the file path
                { appName: 'admin' }
            else
                { appName: 'app' }
        .pipe gulp.dest 'gui/dist/coffee'
        .pipe coffee { bare: true }
        .on 'error', gutil.log

        .pipe ngAnnotate { add:true, single_quotes: true }

compileSass = (options, action) ->
    options or= {}
    options.compass = true
    options.sourcemap = false
    action or= gulp.src
    action 'gui/styles/**/*.scss'
        .pipe sass options
        .on 'error', gutil.log

compileJade = (action) ->
    action or= gulp.src
    action "gui/index.jade"
        .pipe jade()
        .on 'error', gutil.log
        .pipe gulp.dest 'gui/dist/'


#///////////////////////////
#// Exposed Gulp tasks
#//

gulp.task 'jade', ->
    compileJade()

gulp.task 'sass', ->
    compileSass()
        .pipe gulp.dest 'gui/dist/css'
        
gulp.task 'sassRelease', ->
    compileSass { style: 'compressed' }
        .pipe gulp.dest 'gui/dist/css'

gulp.task 'coffee', ->
    compileCoffee()
        .pipe gulp.dest 'gui/dist/js'

gulp.task 'coffeeRelease', ->
    compileCoffee()
        .pipe uglify { mangle: true }
        .pipe gulp.dest 'gui/dist/js'

gulp.task 'copyCssAndFonts', ->
    gulp.src 'gui/styles/themes/**/*.css' 
        .pipe copy 'gui/dist/css', prefix:3
    gulp.src 'gui/styles/fonts/**' 
        .pipe copy 'gui/dist', prefix:2

gulp.task 'buildExecutable', ->
    nw = new NwBuilder
        version: '0.10.5'
        files: artefacts
        platforms: ['win']
        winIco: 'gui/resources/model.ico'
        buildDir: 'bin'
    
    nw.on 'log', (msg) ->
        gutil.log 'node-webkit-builder', msg
    
    nw.build().catch (err) ->
        gutil.log 'node-webkit-builder', err

gulp.task 'buildAndRun', shell.task [ 
        'gulp buildExecutable && cmd /C "start .\\bin\\AngularDependencyGraph\\win\\AngularDependencyGraph.exe"' 
    ]

gulp.task 'run', shell.task [ 
        'cmd /C "start .\\bin\\AngularDependencyGraph\\win\\AngularDependencyGraph.exe"' 
    ]

#///////////////////////////
#// Main pipes
#//

gulp.task 'compileDebug', ['sass', 'coffee', 'jade', 'copyCssAndFonts']

gulp.task 'compileRelease', ['sassRelease', 'coffeeRelease', 'jade', 'copyCssAndFonts']

gulp.task 'build', ['compileRelease', 'buildExecutable']

gulp.task 'default', ['compileRelease', 'buildAndRun']

gulp.task 'debug', ['buildAndRun']


#///////////////////////////
#// Watch
#//

gulp.task 'watch', ->
    gulp.watch 'gui/styles/**/*.scss',   ['sass']  
    gulp.watch 'gui/app/**/*.coffee',    ['coffee']
    gulp.watch 'gui/layout/**/*.jade',   ['jade']
    gulp.watch 'gui/index.jade',         ['jade']