﻿class GraphPreview extends Controller

    
    constructor: ($element, currentProjectService) ->

        _w = $(window)
        _graph = $element.find '.js-graph'
        _resize = -> _graph.height _w.height()

        _w.on 'resize', _resize

        _resize()


        currentProjectService.on 'save,reset,refresh', (project) ->
            return unless project.whenModelReady
            project.whenModelReady
                .then (data) -> 
                    _renderGraph JSON.parse data


        _renderGraph = (model, isUpdate) ->
            
            # init
            svg = d3.select("svg")
            inner = svg.select("g")
            render = new dagreD3.render()
        
            zoom = d3.behavior.zoom().on "zoom", ->
                inner.attr "transform", "translate(#{d3.event.translate}) scale(#{d3.event.scale})"
        
            svg.call zoom
        
            g = new dagreD3.graphlib.Graph()
            g.setGraph
                nodesep: 70
                ranksep: 50
                rankdir: "LR"
                marginx: 20
                marginy: 20

            # set modules
            for module in model
                id = module.name
                className = "running"
                className += " warn"  if module.moduleDependencies.length > 5
                width = id.length * 8 + 24
                html = """
                    <div>
                        <span class=status></span>
                        <span class=name>#{module.name}</span>
                        <span class=queue><span class=counter>#{module.moduleDependencies.length}</span></span>
                    </div>
                """
                g.setNode id,
                    labelType: "html"
                    label: html
                    rx: 5
                    ry: 5
                    padding: 0
                    'class': className

                if module.moduleDependencies
                    for dependency in module.moduleDependencies
                        g.setEdge id, dependency,
                            width: 40
            
            # set external modules
            externalModules = []
            for module in model
                for dependency in module.moduleDependencies
                    unless model.any((x) -> x.name is dependency)
                        externalModules.push dependency
                      
            for moduleName in externalModules
                id = moduleName
                className = "stopped warn external"
                html = """
                    <div>
                        <span class=status></span>
                        <span class=name>#{moduleName}</span>
                        <span class=queue><span class=counter>External</span></span>
                    </div>
                """
                g.setNode id,
                    labelType: "html"
                    label: html
                    rx: 5
                    ry: 5
                    padding: 0
                    'class': className

            # finalize
            inner.call render, g
            zoomScale = zoom.scale()
            graphWidth = g.graph().width + 80
            graphHeight = g.graph().height + 40
            width = parseInt(svg.style("width").replace(/px/, ""))
            height = parseInt(svg.style("height").replace(/px/, ""))
            zoomScale = Math.min(width / graphWidth, height / graphHeight)
            translate = [
                (width / 2) - ((graphWidth * zoomScale) / 2)
                (height / 2) - ((graphHeight * zoomScale) / 2)
            ]
            zoom.translate translate
            zoom.scale zoomScale
            zoom.event ((if isUpdate then svg.transition().duration(500) else d3.select("svg")))
                    

