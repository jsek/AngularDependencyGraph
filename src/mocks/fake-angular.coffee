'use strict';

function Module(name, dependencies) {
  this.name = name
  this.moduleDependencies = dependencies
  this.items = []
}

var angular = {};

var extractDependenciesFromFunction = function (fn) {
  var dependencies = [];
  try {
   dependencies = fn.toString()
     .match(/function \((.|[\r\n])*?\)/)[0]
     .replace(/function /, '')
     .replace(/[\(]/, '')
     .replace(/[\)]/, '')
     .split(',')
     .map(function (x) { return x.trim(); })
     .filter(function (x) { return x.length > 0; });
  } catch (e) { }
  return dependencies;
};


var methods = ['constant', 'controller', 'directive', 'factory', 'filter', 'provider', 'service', 'value']
var globalApis = ['lowercase',
  'uppercase',
  'forEach',
  'extend',
  'identity',
  'noop',
  'isUndefined',
  'isDefined',
  'isObject',
  'isString',
  'isNumber',
  'isDate',
  'isArray',
  'isFunction',
  'isElement',
  'copy',
  'equals',
  'bind',
  'toJson',
  'fromJson',
  'bootstrap',
  'injector',
  'element',
];

methods.forEach(function (method) {
    Module.prototype[method] = function addItem(name, fn) {
        var dependencies = extractDependenciesFromFunction(fn);

        this.items.push({ name: name, dependencies: dependencies });

        return this;
    }
})

Module.prototype.config = function() {
  return this
};

module.exports = function() {
  angular = {
    modules: [],
    modulesMap: {},
    modulesNames: [],
    module: function(name, deps) {
      if (this.modulesNames.indexOf(name)>-1){
        if(deps){
          this.modulesMap[name].moduleDependencies = deps
        }
        return this.modulesMap[name]
      }

      var module = new Module(name,deps)

      this.modulesNames.push(name)
      this.modulesMap[name] = module
      this.modules.push(module)
      return module
    }
  }
  var noop = function(){}
  globalApis.forEach(function(method) {
    angular[method] = noop
  });

  return angular
}
