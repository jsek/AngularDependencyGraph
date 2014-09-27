fs = require("node-fs")
Utils = require("../mocks/fake-UtilsNamespace")()
document = window = navigator = {}


log = (grunt, results, verbose) ->
    if verbose
        for r in results when r.error
            grunt.log.writeln "#{r.id} skipped due to error: #{r.exception}"

    skipped = results.count (r) -> r.error
    processed = results.length - skipped
    grunt.log.writeln "\n >>> #{processed} processed files (#{skipped} skipped)"


module.exports = (grunt, scripts, options) ->
    angular = require("../mocks/fake-angular")()

    results = scripts.map (script) ->
        try
            eval script.text
            return {
                id: script.id, 
                error: false 
            } 

        catch exception
            return {
                id: script.id
                error: true
                exception
            }

    log(grunt, results, options.verbose)

    # TODO: dirty
    angular.modules.names = angular.modulesNames

    return angular.modules