class GraphPreview extends Controller

    _graph = undefined

    _renderGraph = (model) ->

        data = JSON.parse model
        
        draw = (isUpdate) ->
            for module in data
                id = module.name
                className = ((if module.moduleDependencies.length > 0 then "running" else "stopped"))
                className += " warn"  if module.moduleDependencies.length > 10
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
                        g.setEdge dependency, id,
                            label: "uses"
                            width: 40
            
            externalModules = []
            for module in data
                for dependency in module.moduleDependencies
                    unless data.any((x) -> x.name is dependency)
                        externalModules.push dependency
                      
            for moduleName in externalModules
                id = moduleName
                className = "stopped warn external"
                html = """
                    <div>
                        <span class=status></span>
                        <span class=name>#{module.name}</span>
                        <span class=queue><span class=counter>?</span></span>
                    </div>
                """
                g.setNode id,
                    labelType: "html"
                    label: html
                    rx: 5
                    ry: 5
                    padding: 0
                    'class': className

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
            

        svg = d3.select("svg")
        inner = svg.select("g")
        zoom = d3.behavior.zoom().on("zoom", ->
            inner.attr "transform", "translate(" + d3.event.translate + ")" + "scale(" + d3.event.scale + ")"
            return
        )
        svg.call zoom
        render = new dagreD3.render()
        g = new dagreD3.graphlib.Graph()
        g.setGraph
            nodesep: 70
            ranksep: 50
            rankdir: "LR"
            marginx: 20
            marginy: 20

        draw()

    constructor: ($element, currentProjectService) ->

        _graph = $element.find '.js-graph'

        currentProjectService.on 'save,reset,refresh', (project) ->
            return unless project.whenModelReady
            project.whenModelReady
                .then (model) -> 
                    _renderGraph model
                    