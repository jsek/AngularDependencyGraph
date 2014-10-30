class GraphPreview extends Controller

    _graph = undefined

    _renderGraph = (model) ->

        # TODO
        _graph.text model


    constructor: ($element, currentProjectService) ->

        _graph = $element.find '.js-graph'                

        currentProjectService.on 'save,reset,refresh', (project) ->
            return unless project.whenModelReady
            project.whenModelReady
                .then (model) -> 
                    _renderGraph model
                    