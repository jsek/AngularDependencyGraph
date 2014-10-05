# * Credits to "grunt-angular-modules-graph" by Carlo Colombo

require "../src/utils/utils"
parser      = require "../src/parser/parser"
filter      = require "../src/formatter/filter"
formatter   = require "../src/formatter/formatter"
template    = require "../src/templates/graph-template"

document = window = navigator = {}

module.exports = (grunt) ->

    log = (source, destination) ->
        grunt.log.writeln "Generating", grunt.log.wordlist(source), "->", destination
    
    grunt.registerMultiTask "generate", "Generate modules dependencies graph in .dot format", ->
        
        # Merge options
        options = @options
            colors:
                externalDependencies: "red"

            ignore            : []
            verbose           : false
            showEmptyItems    : false
      
            rootModule        : null
            levelLimit: { above: null, below: null }

        for destination of @data.files
            # Read files
            source = @data.files[destination]
            scripts = grunt.file
                .expand {}, source
                .map (file) ->
                    id: file
                    text: grunt.file.read(file)
            
            # Parse
            modules = parser(grunt, scripts, options)
            # Filter ignored
            modules = filter(modules, options)
            # Format: Limit levels for given root
            modules = formatter(modules, options)
            
            # Generate graph specification (.dot)    
            grunt.file.write destination, grunt.template.process template,
                data: {
                    modules
                    options
                }

            log source, destination