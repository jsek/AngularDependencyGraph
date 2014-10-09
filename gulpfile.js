(function() {
  var NwBuilder, coffee, compileCoffee, compileJade, compileSass, grep, gulp, gutil, jade, jadeInherit, ngAnnotate, ngClassify, sass, uglify;

  gulp = require('gulp');

  gutil = require('gulp-util');

  coffee = require('gulp-coffee');

  ngAnnotate = require('gulp-ng-annotate');

  uglify = require('gulp-uglify');

  ngClassify = require('gulp-ng-classify');

  sass = require('gulp-ruby-sass');

  jade = require('gulp-jade');

  jadeInherit = require('gulp-jade-inheritance');

  grep = require('gulp-grep-stream');

  NwBuilder = require('node-webkit-builder');

  compileCoffee = function(action) {
    action || (action = gulp.src);
    return action('gui/app/**/*.coffee').pipe(ngClassify(function(file) {
      if (file.path.indexOf('admin') !== -1) {
        return {
          appName: 'admin'
        };
      } else {
        return {
          appName: 'app'
        };
      }
    })).pipe(coffee({
      bare: true
    })).on('error', gutil.log).pipe(ngAnnotate({
      add: true,
      single_quotes: true
    }));
  };

  compileSass = function(options, action) {
    options || (options = {});
    options.compass = true;
    options.sourcemap = false;
    action || (action = gulp.src);
    return action('gui/styles/**/*.scss').pipe(sass(options)).on('error', gutil.log);
  };

  compileJade = function(action) {
    action || (action = gulp.src);
    action('gui/views/**/*.jade').pipe(jadeInherit({
      basedir: '/gui/'
    })).pipe(jade()).on('error', gutil.log).pipe(gulp.dest('gui/dist/views'));
    return action("gui/index.jade").pipe(jade()).on('error', gutil.log).pipe(gulp.dest('gui/dist/'));
  };

  gulp.task('jade', function() {
    return compileJade();
  });

  gulp.task('sass', function() {
    return compileSass().pipe(gulp.dest('gui/dist/css'));
  });

  gulp.task('sassRelease', function() {
    return compileSass({
      style: 'compressed'
    }).pipe(gulp.dest('gui/dist/css'));
  });

  gulp.task('coffee', function() {
    return compileCoffee().pipe(gulp.dest('gui/dist/js'));
  });

  gulp.task('coffeeRelease', function() {
    return compileCoffee().pipe(uglify({
      mangle: true
    })).pipe(gulp.dest('gui/dist/js'));
  });

  gulp.task('buildExecutable', function() {
    var nw;
    nw = new NwBuilder({
      version: '0.10.5',
      files: ['./package.json', './gui/dist/**', './gui/vendor/**'],
      platforms: ['win']
    });
    nw.on('log', function(msg) {
      return gutil.log('node-webkit-builder', msg);
    });
    return nw.build()["catch"](function(err) {
      return gutil.log('node-webkit-builder', err);
    });
  });

  gulp.task('build', ['buildExecutable']);

  gulp.task('compileDebug', ['sass', 'coffee', 'jade']);

  gulp.task('compileRelease', ['sassRelease', 'coffeeRelease', 'jade']);

  gulp.task('watch', function() {
    gulp.watch('gui/styles/**/*.scss', ['sass']);
    gulp.watch('gui/app/**/*.coffee', ['coffee']);
    gulp.watch('gui/views/**/*.jade', ['jade']);
    return gulp.watch('gui/index.jade', ['jade']);
  });

}).call(this);
