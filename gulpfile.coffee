gulp        = require 'gulp'
gutil       = require 'gulp-util'
coffee      = require 'gulp-coffee'
ngAnnotate  = require 'gulp-ng-annotate'
uglify      = require 'gulp-uglify'
ngClassify  = require 'gulp-ng-classify'
sass        = require 'gulp-ruby-sass'
jade        = require 'gulp-jade'
jadeInherit = require 'gulp-jade-inheritance'
grep        = require 'gulp-grep-stream'


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
        #.pipe gulp.dest 'gui/dist/scripts-classified'
        .pipe coffee { bare: true }
        .on 'error', gutil.log

        .pipe ngAnnotate { add:true, single_quotes: true }


compileSass = (options, action) ->
    options or= {}
    options.compass = true
    action or= gulp.src
    action 'gui/styles/**/*.sass'
        .pipe sass options
        .on 'error', gutil.log


compileJade = (action) ->
    action or= gulp.src
    action 'gui/views/**/*.jade'
        .pipe jadeInherit { basedir: '/gui/' }
        .pipe jade()
        #.pipe grep '_*'
        .on 'error', gutil.log
        .pipe gulp.dest 'gui/dist/views'

    action "gui/index.jade"
        .pipe jade()
        .on 'error', gutil.log
        .pipe gulp.dest 'gui/dist/'


#///////////////////////////
#// Exposed Gulp tasks
#//

gulp.task 'sass', ->
    compileSass()
        .pipe gulp.dest 'gui/dist/css'

gulp.task 'coffee', ->
    compileCoffee()
        .pipe gulp.dest 'gui/dist/js'

gulp.task 'jade', ->
    compileJade()


#///////////////////////////
#// Main pipes
#//

gulp.task 'debug', ['sass', 'coffee', 'jade']

gulp.task 'release', ->
    
    compileCoffee()
        .pipe uglify { mangle: true }
        .pipe gulp.dest 'gui/dist/js'

    compileSass { style: 'compressed' }
        .pipe gulp.dest 'gui/dist/css'

    compileJade()


#///////////////////////////
#// Watch
#//

gulp.task 'watch', ->
    gulp.watch 'gui/styles/**/*.sass',   ['sass']  
    gulp.watch 'gui/app/**/*.coffee',    ['coffee']
    gulp.watch 'gui/views/**/*.jade',    ['jade']
    gulp.watch 'gui/index.jade',         ['jade']

###
gulp.task 'watch', ->
    compileCoffee watch
        .pipe gulp.dest 'gui/dist/js'

    compileSass {}, gulp.watch
        .pipe gulp.dest 'gui/dist/css'

    compileJade gulp.watch

###
