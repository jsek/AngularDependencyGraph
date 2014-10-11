fs = require 'node-fs'
jade = require 'jade'

# TODO: 
    # Add icon 
    # Collapse by default

class Search extends Controller
    constructor: ($scope) ->
        
        @container = $('.quick-search')

        $scope.expand = ->
            # autofocus input
            # bind event on focusout (here?)