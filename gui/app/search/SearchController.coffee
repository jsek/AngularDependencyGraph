fs = require 'node-fs'
jade = require 'jade'

# TODO: 
    # Add icon 
    # Collapse by default

class Search extends Controller
    constructor: ($scope, $element) ->
        
        Placeholdem($element.find('[placeholder]'))

        @container = $('.quick-search')

        $scope.expand = ->
            # autofocus input
            # bind event on focusout (here?)