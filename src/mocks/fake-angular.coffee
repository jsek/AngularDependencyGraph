Module = (name, dependencies) ->
  @name = name
  @moduleDependencies = dependencies
  @items = []
  return
"use strict"
angular = {}
extractDependenciesFromFunction = (fn) ->
  dependencies = []
  try
    dependencies = fn.toString().match(/function \((.|[\r\n])*?\)/)[0].replace(/function /, "").replace(/[\(]/, "").replace(/[\)]/, "").split(",").map((x) ->
      x.trim()
    ).filter((x) ->
      x.length > 0
    )
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
methods.forEach (method) ->
  Module::[method] = addItem = (name, fn) ->
    dependencies = extractDependenciesFromFunction(fn)
    @items.push
      name: name
      dependencies: dependencies

    this

  return

Module::config = ->
  this

module.exports = ->
  angular =
    modules: []
    modulesMap: {}
    modulesNames: []
    module: (name, deps) ->
      if @modulesNames.indexOf(name) > -1
        @modulesMap[name].moduleDependencies = deps  if deps
        return @modulesMap[name]
      module = new Module(name, deps)
      @modulesNames.push name
      @modulesMap[name] = module
      @modules.push module
      module

  noop = ->

  globalApis.forEach (method) ->
    angular[method] = noop
    return

  angular