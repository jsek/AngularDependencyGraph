
hasChild = (parent, child) -> 
    parent.moduleDependencies.indexOf(child.name) < 0    

isAbove = (node, child, limit) ->
    hasChild(node, child) \
        and node.level is -1 \
        and (node.level = child.level + 1) > limit
        
isBelow = (node, parent, limit) ->
    hasChild(parent, node) \
        and node.level is -1 \
        and (node.level = parent.level + 1) > limit
            
# Finds and filters neighbours above some node
getNeighboursAbove = (nodes, child, limit) ->
    n for n in nodes when !n.visited and isAbove(n, child, limit)

# Finds and filters neighbours below some node
getNeighboursBelow = (nodes, parent, limit) ->
    n for n in nodes when !n.visited and isBelow(n, parent, limit)

# Traverses dependency tree
bfs = (nodes, root, limit, neighboursFn) ->
    node.level = -1 for node in nodes
    root.level = 0
    root.visited = false

    queue = []
    queue.push root
    until queue.isEmpty()
        node = queue.shift()
        unless node.visited
            node.visited = true
            filteredNeighbours = neighboursFn(nodes, node, limit)
            queue.push.apply(queue, filteredNeighbours)


module.exports = (nodes, options) ->

    rootName = options.rootModule
    unless rootName?
        return nodes
    
    limitAbove = options.levelLimit.above
    limitBelow = options.levelLimit.below
    
    findNode = (name) ->
        nodes.find (x) ->
            x.name is name

    rootNode = findNode(rootName)
    unless rootNode?
        console.warn ">>> Error: Root node was not found"
        return nodes

    # Initialize required fields
    for x in nodes
        x.visited = false
        x.level = (if x.name is rootName then 0 else -1)

    # Visit valid nodes
    bfs(nodes, rootNode, limitBelow, getNeighboursBelow) if limitBelow?
    bfs(nodes, rootNode, limitAbove, getNeighboursAbove) if limitAbove?
    
    # Take only visited
    result = nodes
        .filter (n) -> n.visited
        .map (n) ->
            n.moduleDependencies = n.moduleDependencies
                .filter (depName) -> 
                    findNode(depName)?.visited
            delete n.visited
            delete n.level
            n
    
    result.names = nodes.names
    
    return result
