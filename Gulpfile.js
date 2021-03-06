(function() {
  var NwBuilder, artefacts, coffee, compileCoffee, compileJade, compileSass, copy, gulp, gutil, jade, ngAnnotate, ngClassify, sass, shell, uglify;

  gulp = require('gulp');

  gutil = require('gulp-util');

  shell = require('gulp-shell');

  coffee = require('gulp-coffee');

  ngAnnotate = require('gulp-ng-annotate');

  uglify = require('gulp-uglify');

  ngClassify = require('gulp-ng-classify');

  sass = require('gulp-ruby-sass');

  jade = require('gulp-jade');

  copy = require('gulp-copy');

  NwBuilder = require('node-webkit-builder');

  artefacts = ['gui/dist/**', 'gui/resources/**', 'gui/vendor/**', 'gui/views/**', 'package.json', 'src/**', 'tasks/**', 'node_modules/jade/**', 'node_modules/node-fs/**', 'node_modules/grunt/**', 'node_modules/grunt-cli/**', 'node_modules/.bin/grunt.cmd'];

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
    })).pipe(gulp.dest('gui/dist/coffee')).pipe(coffee({
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

  gulp.task('copyCssAndFonts', function() {
    gulp.src('gui/styles/themes/**/*.css').pipe(copy('gui/dist/css', {
      prefix: 3
    }));
    return gulp.src('gui/styles/fonts/**').pipe(copy('gui/dist', {
      prefix: 2
    }));
  });

  gulp.task('buildExecutable', function() {
    var nw;
    nw = new NwBuilder({
      version: '0.10.5',
      files: artefacts,
      platforms: ['win'],
      winIco: 'gui/resources/model.ico',
      buildDir: 'bin'
    });
    nw.on('log', function(msg) {
      return gutil.log('node-webkit-builder', msg);
    });
    return nw.build()["catch"](function(err) {
      return gutil.log('node-webkit-builder', err);
    });
  });

  gulp.task('buildAndRun', shell.task(['gulp buildExecutable && cmd /C "start .\\bin\\AngularDependencyGraph\\win\\AngularDependencyGraph.exe"']));

  gulp.task('run', shell.task(['cmd /C "start .\\bin\\AngularDependencyGraph\\win\\AngularDependencyGraph.exe"']));

  gulp.task('compileDebug', ['sass', 'coffee', 'jade', 'copyCssAndFonts']);

  gulp.task('compileRelease', ['sassRelease', 'coffeeRelease', 'jade', 'copyCssAndFonts']);

  gulp.task('build', ['compileRelease', 'buildExecutable']);

  gulp.task('default', ['compileRelease', 'buildAndRun']);

  gulp.task('debug', ['buildAndRun']);

  gulp.task('watch', function() {
    gulp.watch('gui/styles/**/*.scss', ['sass']);
    gulp.watch('gui/app/**/*.coffee', ['coffee']);
    gulp.watch('gui/layout/**/*.jade', ['jade']);
    return gulp.watch('gui/index.jade', ['jade']);
  });

}).call(this);
