require '../utils/arrayUtils'
Module = require('./module')

class FakeAngular
    constructor: ->
        @modules = []
        @modulesMap = {}
        @modulesNames = []
    
    module: (name, moduleDependencies) ->
        if @modulesNames.contains(name)
            @modulesMap[name].moduleDependencies = moduleDependencies  if moduleDependencies?
            return @modulesMap[name]
        # else
        newModule = new Module(name, moduleDependencies)
        @modulesNames.push name
        @modulesMap[name] = newModule
        @modules.push newModule
        return newModule

globalApis = [
    "lowercase"
    "uppercase"
    "forEach"
    "extend"
    "identity"
    "noop"
    "isUndefined"
    "isDefined"
    "isObject"
    "isString"
    "isNumber"
    "isDate"
    "isArray"
    "isFunction"
    "isElement"
    "copy"
    "equals"
    "bind"
    "toJson"
    "fromJson"
    "bootstrap"
    "injector"
    "element"
]

for method in globalApis
    FakeAngular::[method] = -> # empty

module.exports = FakeAngular