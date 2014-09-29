class Module
    constructor: (@name, @moduleDependencies) ->
    items: []

extractDependenciesFromFunction = (fn) ->
    dependencies = []
    try
        dependencies = fn.toString()
            .match(/function \((.|[\r\n])*?\)/)[0]
            .replace(/function /, "")
            .replace(/[\(\)]/, "")
            .split(",").map (x) -> x.trim()
            .filter (x) ->
            x.length > 0
        
    dependencies

methods = [
    "constant"
    "controller"
    "directive"
    "factory"
    "filter"
    "provider"
    "service"
    "value"
]

for method in methods
    Module::[method] = (name, fn) ->
        dependencies = extractDependenciesFromFunction(fn)
        @items.push
            name: name
            dependencies: dependencies

        this

Module::config = -> this

module.exports = ->
    'class': Module