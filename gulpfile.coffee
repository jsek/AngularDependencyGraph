gulp        = require 'gulp'
gutil       = require 'gulp-util'
coffee      = require 'gulp-coffee'
ngAnnotate  = require 'gulp-ng-annotate'
uglify      = require 'gulp-uglify'
ngClassify  = require 'gulp-ng-classify'
#sass        = require 'gulp-ruby-sass'

gulp.task 'default', ->
    gulp.src 'gui/app/**/*.coffee'
        .pipe ngClassify (file) ->
            
            if file.path.indexOf('admin') isnt -1  # use 'admin' as the appName if 'admin' is found in the file path
                { appName: 'admin' }
            else
                { appName: 'app' }

        .pipe gulp.dest 'gui/dist/scripts-classified'

        .pipe coffee { bare: true }
        .on 'error', gutil.log

        .pipe ngAnnotate { add:true, single_quotes: true }

        .pipe uglify { mangle:true }

        .pipe gulp.dest 'gui/dist/js'