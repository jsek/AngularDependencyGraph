module.exports = '
    digraph dependencies{\n
        compound = true;\n
        node[
                fontname = "Verdana",
                fontsize = "9"
            ];\n
        <% _.forEach(modules, function(module){ %>
            subgraph cluster_<%- module.name %> {
                label = "<%- module.name %>";\n
                <% _.forEach(module.items, function(item){ %>
                    \t"<%- item.name %>" 
                        [
                            <% item.color != undefined
                                ? print(\'style=filled, fillcolor="\'+ item.color +\'"\') 
                                : print(\'\') %>
                        ];\n
                <%}) %>
            }\n
        <%}) %>

        <% _.forEach(modules, function(module){ %>
            <% _.forEach(module.items, function(item){ %>
                <% _.forEach(item.dependencies, function(dependency){ %>
                    "<%- item.name %>" -> "<%- dependency %>";\n
                <%}) %>
            <%}) %>
        <%}) %>

        <% _.forEach(modules, function(module){ %>
            <% _.forEach(module.moduleDependencies, function(dependency){ %>
                \t"<%- (module || {items:[{name:"?"}]}).items[0].name %>" -> "<%- (_.find(modules, function(m) { return m.name === dependency ; }) || {items:[{name:"?"}]}).items[0].name %>"
                    [
                        ltail = cluster_<%- module.name %>,
                        lhead = cluster_<%- dependency %>,
                        arrowhead = empty,
                        color = "<% modules.names.indexOf(dependency) > -1 
                            ? print(\'gray\') 
                            : print(options.colors.externalDependencies) %>"
                    ]\n
            <%}) %>
        <%}) %>
     }
'