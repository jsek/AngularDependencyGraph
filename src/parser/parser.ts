var fs = require("node-fs");
var Utils = require("../mocks/fake-UtilsNamespace");
var FakeAngular = require("../mocks/fake-angular");
document = window = navigator = {};


var log = (grunt, results, verbose) => {
    if (verbose) {
        results
            .filter((r) => r.error)
            .forEach((r) => {
                grunt.log.writeln("#{r.id} skipped due to error: #{r.exception}");
            });
    }

    var skipped = results.count((r) => r.error);
    var processed = results.length - skipped;
    grunt.log.writeln("\n >>> #{processed} processed files (#{skipped} skipped)");
};

angular = {};

module.exports = (grunt, scripts, options) => {
    angular = new FakeAngular()

    results = scripts.map((script) => {
        try {
            eval(script.text);
            return {
                id: script.id,
                error: false
            };
        } catch (exception) {
            return {
                id: script.id,
                error: true,
                exception
            };
        }
    });

    log(grunt, results, options.verbose);

    // TODO: dirty
    angular.modules.names = angular.modulesNames;

    return angular.modules;
};
