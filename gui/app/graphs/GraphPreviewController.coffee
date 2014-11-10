class GraphPreview extends Controller
    
    constructor: ($element, currentProjectService, graphNodeService) ->

        _w = $(window)
        _graph = $element.find '.js-graph'
        _resize = -> _graph.height _w.height()

        _w.on 'resize', _resize
        _resize()
        
        container = undefined
        svg = $svg = undefined
        render = new dagreD3.render()

        _graphBaseSettings = 
            nodesep: 70
            ranksep: 50
            rankdir: 'LR'
            marginx: 20
            marginy: 20

        currentProjectService.on 'save,reset,refresh', (project) ->
            return unless project.whenModelReady
            project.whenModelReady
                .then (model) -> 
                    _renderGraph model
                    
        _renderGraph = (model, isUpdate) ->
            
            unless isUpdate
                $svg = $('svg')
                svg = d3.select('svg')
                container = svg.select('g')
            
            zoom = d3.behavior.zoom().on 'zoom', ->
                container.attr 'transform', "translate(#{d3.event.translate}) scale(#{d3.event.scale})"
            
            g = new dagreD3.graphlib.Graph()
            g.setGraph _graphBaseSettings
            _setNodesAndEdges model, g
            
            container.call render, g
            _applySizeAndZoom zoom, g

            zoom.event (if isUpdate then svg.transition().duration(500) else d3.select('svg'))


        _setNodesAndEdges = (model, graph) ->
                
            for module in model.modules
                graphNodeService
                    .createInternal module
                    .applyFor graph
            
            for moduleName in model.externalModules
                graphNodeService
                    .createExternal moduleName
                    .applyFor graph

                    
        _applySizeAndZoom = (zoom, graph) ->
            svg.call zoom
            
            graphWidth = graph.graph().width + 80
            graphHeight = graph.graph().height + 40
            clientWidth = $svg.width()
            clientHeight = $svg.height()

            zoomScale = Math.min.apply {}, [
                1
                clientWidth / graphWidth
                clientHeight / graphHeight
            ]
            zoom.scale zoomScale
            
            centerPoint = [
                (clientWidth - graphWidth * zoomScale) / 2
                (clientHeight - graphHeight * zoomScale) / 2
            ]
            zoom.translate centerPoint
            
            