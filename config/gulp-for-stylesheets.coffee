gulp            = require('gulp')
$               = require('gulp-load-plugins')()
reporters       = require('./scsslint.reporters')

SCSSLINT_CONFIG = 'config/scsslint.config.yml'
SCSS_PATH       = 'gui/styles/components/**/*.scss'


gulp.task 'scsslint', ->
    gulp.src SCSS_PATH
        .pipe $.scssLint(config: SCSSLINT_CONFIG, customReport: reporters.suppress)
        .pipe reporters.stylish()


gulp.task 'scsslint_errors', ->
    gulp.src SCSS_PATH
        .pipe $.scssLint(config: SCSSLINT_CONFIG, customReport: reporters.suppress)
        .pipe reporters.stylishErrors()


gulp.task 'scsslint_debug', ->
    gulp.src SCSS_PATH
        .pipe $.scssLint(config: SCSSLINT_CONFIG, customReport: reporters.visualstudio)


gulp.task 'scsslint_watch', ->
    gulp.src SCSS_PATH
        .pipe $.scssLint(config: SCSSLINT_CONFIG, customReport: reporters.stylish, endless: true)


gulp.task 'csscss', ->
    gulp.src 'gui/dist/css/**/*.css'
        .pipe $.csscss()


gulp.task 'watch_scss', ->
    gulp.watch SCSS_PATH, [ 'scsslint_watch' ]
    

gulp.task 'check_stylesheets', [ 'scsslint', 'csscss' ]
