gulp        = require 'gulp'
gutil       = require 'gulp-util'
coffee      = require 'gulp-coffee'
ngAnnotate  = require 'gulp-ng-annotate'
uglify      = require 'gulp-uglify'
ngClassify  = require 'gulp-ng-classify'
sass        = require 'gulp-ruby-sass'
jade        = require 'gulp-jade'
NwBuilder   = require 'node-webkit-builder'


modulesForGUI = [
    './node_modules/node-fs/**'
    './node_modules/jade/**'
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

gulp.task 'buildExecutable', ->
    nw = new NwBuilder
        version: '0.10.5'
        files: ['./package.json', './gui/dist/**', './gui/vendor/**', './gui/views/**'].concat modulesForGUI
        platforms: ['win']
    
    nw.on 'log', (msg) ->
        gutil.log 'node-webkit-builder', msg
    
    nw.build().catch (err) ->
        gutil.log 'node-webkit-builder', err


#///////////////////////////
#// Main pipes
#//

gulp.task 'compileDebug', ['sass', 'coffee', 'jade']

gulp.task 'compileRelease', ['sassRelease', 'coffeeRelease', 'jade']

gulp.task 'build', ['compileRelease', 'buildExecutable']


#///////////////////////////
#// Watch
#//

gulp.task 'watch', ->
    gulp.watch 'gui/styles/**/*.scss',   ['sass']  
    gulp.watch 'gui/app/**/*.coffee',    ['coffee']
    gulp.watch 'gui/layout/**/*.jade',   ['jade']
    gulp.watch 'gui/index.jade',         ['jade']
