(function() {
  module.exports = function(grunt) {
    var all_coffeeScript, all_coffeeScript_andViews, all_javaScript, jshintOptions, nodeunitReporter, scripts_with_eval;
    nodeunitReporter = process.env.ANGULARDEPENDENCYGRAPH_COVERAGE ? 'lcov' : 'default';
    all_coffeeScript = ['src/**/*.coffee', 'tasks/**/*.coffee', 'tests/**/*.coffee', 'config/**/*.coffee', 'Gruntfile.coffee', 'Gulpfile.coffee'];
    all_javaScript = all_coffeeScript.map(function(x) {
      return x.replace('.coffee', '.js');
    });
    all_coffeeScript_andViews = all_coffeeScript.concat(['gui/views/jade/**/*.jade']);
    scripts_with_eval = ["src/**/parser.js", "Gruntfile.js"];
    jshintOptions = {
      "-W030": true,
      "eqnull": true,
      "loopfunc": true,
      "node": true
    };
    grunt.initConfig({
      generate: {
        options: {
          showEmptyItems: false,
          verbose: true,
          colors: {
            externalDependencies: 'red'
          },
          ignore: ['$*', 'ng*']
        },
        compile: {
          files: {
            "./examples/simple.dot": ["./examples/simple/**/*.js"],
            "./examples/complex.dot": ["./examples/complex/**/*.js"]
          }
        }
      },
      graphviz: {
        options: {
          bin: '../GraphViz/bin/'
        },
        compile: {
          files: {
            "./examples/simple.svg": "./examples/simple.dot",
            "./examples/complex.png": "./examples/complex.dot",
            "./examples/complex.svg": "./examples/complex.dot"
          }
        }
      },
      coffee: {
        all: {
          expand: true,
          bare: true,
          cwd: '.',
          src: all_coffeeScript,
          dest: '.',
          ext: '.js'
        }
      },
      coffeelint: {
        all: all_coffeeScript,
        options: {
          configFile: 'coffeelint.json'
        }
      },
      nodeunit: {
        options: {
          reporter: nodeunitReporter
        },
        files: ['tests/**/*Specs.js']
      },
      watch: {
        coffeescript: {
          files: all_coffeeScript_andViews,
          tasks: ['newer:coffeelint', 'newer:coffee', 'newer:jshint:all']
        }
      },
      jshint: {
        all: {
          options: (function() {
            var newOptions;
            newOptions = Object.create(jshintOptions);
            newOptions.ignores = scripts_with_eval.concat('tests/**/*_fixture.js');
            return newOptions;
          })(),
          files: {
            src: all_javaScript
          }
        },
        withEval: {
          options: (function() {
            var newOptions;
            newOptions = Object.create(jshintOptions);
            newOptions['-W061'] = true;
            return newOptions;
          })(),
          files: {
            src: scripts_with_eval
          }
        }
      }
    });
    grunt.loadNpmTasks('grunt-contrib-nodeunit');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-coffeelint');
    grunt.loadNpmTasks('grunt-newer');
    grunt.loadTasks('tasks');
    grunt.registerTask('default', ['generate', 'graphviz']);
    grunt.registerTask('validate', ['coffeelint', 'jshint']);
    grunt.registerTask('build', ['coffee', 'validate']);
    return grunt.registerTask('test', ['nodeunit']);
  };

}).call(this);
