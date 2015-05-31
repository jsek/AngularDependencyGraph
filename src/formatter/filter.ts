
var applyIgnoreScope = (modules, scope) => {
    modules.ignoreScope(scope, (x) => x.name)
        .map((m) => {
            m.items = m.items.distinct((i) => i.name);
            m.moduleDependencies = m.moduleDependencies?.ignoreScope(scope) || [];
            if (m.items.length > 0) {
                m.items.forEach((i) => {
                    i.dependencies = i.dependencies?.ignoreScope(scope) || [];
                });
            }
            else {
                m.items.push({ name: "<empty>" });
            }
            return m;
        });
};

module.exports = (nodes, options) => {

    var result = applyIgnoreScope(nodes, options.ignore);
    result.names = nodes.names?.ignoreScope(options.ignore) || [];

    return result;
};
