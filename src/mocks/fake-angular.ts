/// </// <reference path="../utils/arrayUtils.ts"/>

require('../utils/arrayUtils');
var Module = require('./module');

class FakeAngular {
    modules: Array<Module>;
    modulesMap: any;
    modulesNames: Array<string>;

    constructor() {
        this.modules = [];
        this.modulesMap = {};
        this.modulesNames = [];
    }

    module(name, moduleDependencies) {
        if (this.modulesNames.contains(name)) {
            if (moduleDependencies?) {
                this.modulesMap[name].moduleDependencies = moduleDependencies;
            }
            return this.modulesMap[name];
        } else {
            newModule = new Module(name, moduleDependencies);
            this.modulesNames.push(name);
            this.modulesMap[name] = newModule;
            this.modules.push(newModule);
            return newModule;
        }
    }
}

var globalApis = [
    "lowercase",
    "uppercase",
    "forEach",
    "extend",
    "identity",
    "noop",
    "isUndefined",
    "isDefined",
    "isObject",
    "isString",
    "isNumber",
    "isDate",
    "isArray",
    "isFunction",
    "isElement",
    "copy",
    "equals",
    "bind",
    "toJson",
    "fromJson",
    "bootstrap",
    "injector",
    "element"
];

globalApis.forEach((method) => {
    FakeAngular.prototype[method] = () => {}; // empty
});

exports = FakeAngular;
