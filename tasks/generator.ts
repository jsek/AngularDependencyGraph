// * Credits to "grunt-angular-modules-graph" by Carlo Colombo

require ("../src/utils/utils");
var parser      = require("../src/parser/parser");
var filter      = require("../src/formatter/filter");
var template    = require("../src/templates/graph-template");

document = window = navigator = {};

module.exports = (grunt) => {

    var log = (source, destination) => {
        grunt.log.writeln("Generating", grunt.log.wordlist(source), "->", destination);
    };

    grunt.registerMultiTask("generate", "Generate modules dependencies graph in .dot format", () => {

        # Merge options
        var options = this.options({
            colors: {
                externalDependencies: "red"
            },
            ignore            : [],
            verbose           : false,
            showEmptyItems    : false,

            rootModule        : null,
            levelLimit: { above: null, below: null }
        });

        for (destination of this.data.files) {
            # Read files
            var source = this.data.files[destination];
            var scripts = grunt.file
                .expand({}, source)
                .map((file) => {
                    id: file
                    text: grunt.file.read(file)
                });

            # Parse
            var modules = parser(grunt, scripts, options);
            # Filter ignored
            modules = filter(modules, options);

            # Generate graph specification (.dot)
            grunt.file.write(destination, grunt.template.process template, {
                data: {
                    modules: modules,
                    options: options
                }
            });

            log(source, destination);

            # set external modules
            var externalModules = [];
            modules.forEach((module) => {
                module.moduleDependencies.forEach((dependency) => {
                    if (!modules.any((x) => x.name === dependency)) {
                        externalModules.push(dependency);
                    }
                });
            });

            externalModules = externalModules.distinct();

            var model = {
                modules: modules,
                externalModules: externalModules
            }

            if (options.json) {
                    var jsonFile = destination.replace(/[\\\/\.][^\\\/\.]*$/,'.json'); // TODO: string::ReplaceExtension
                    grunt.file.write(jsonFile, JSON.stringify(model));
            }
        }
    }
}
