class GraphPreview extends Controller

    _graph = undefined

    constructor: ($element, currentProjectService) ->

        _graph = $element.find '.js-graph'                

        currentProjectService.on 'reset', (project) ->
            return unless project.whenModelReady
            project.whenModelReady
                .then -> console.log 'model loaded'
                    

        console.log '>> [Intro] loaded'