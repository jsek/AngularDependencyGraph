jade = require 'jade'

_templates = 
    internal: jade.compile '''
        .status
        div
            .name #{title}
            .counter #{params.count}
        '''
    external: jade.compile '''
        .status
        div
            .name #{title}
            .counter External
        ''' 

    
class NodeBase
    _compiledTemplate = undefined
    
    constructor: (@title) ->
        @edgeWidth = 40
        
    setNode: (graph, className) ->
        graph.setNode @title,
            labelType: 'html'
            label: @template(@)
            rx: 5
            ry: 5
            padding: 0
            'class': className

            
class NodeInternal extends NodeBase
    constructor: (@title, @params) ->
        super(@title)
    
    template: _templates.internal
    
    applyFor: (graph) ->
        className = 'internal'
        className += ' warn'  if @params.count > 5
        @setNode(graph, className)
        @setEdges(graph)
    
    setEdges: (graph) ->
        return  unless @params.dependencies
        for dependency in @params.dependencies
            graph.setEdge @title, dependency,
                width: @edgeWidth
    
        
class NodeExternal extends NodeBase
    constructor: (@title) ->
        super(@title)

    template: _templates.external
    
    applyFor: (graph) -> 
        @setNode(graph, 'external')


class GraphNode extends Service
    constructor: ->
    
    createInternal: (module) -> 
        new NodeInternal module.name,
            dependencies: module.moduleDependencies
            count: module.moduleDependencies.length

    createExternal: (module) -> 
            new NodeExternal module
        
        