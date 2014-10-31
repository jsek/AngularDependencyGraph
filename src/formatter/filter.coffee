
applyIgnoreScope = (modules, scope) ->
    modules.ignoreScope scope, (x) -> x.name
        .map (m) ->
            m.items = m.items.distinct (i) -> i.name
            m.moduleDependencies = m.moduleDependencies?.ignoreScope(scope) or []
            if m.items.length > 0
                for i in m.items
                    i.dependencies = i.dependencies?.ignoreScope(scope) or []
            else
                m.items.push { name: "<empty>" }
            m

module.exports = (nodes, options) ->
    
    result = applyIgnoreScope(nodes, options.ignore)
    result.names = nodes.names?.ignoreScope(options.ignore) or []

    return result