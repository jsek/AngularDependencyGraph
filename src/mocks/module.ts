class Module {
    private items: Array<any>;

    constructor(public name: string, public moduleDependencies: Array<string>) {
        this.items = [];
    }
}

var extractDependenciesFromFunction = (fn) => {
    var dependencies = [];
    try {
        dependencies = fn.toString()
            .match(/function \((.|[\r\n])*?\)/)[0]
            .replace(/function/, "")
            .replace(/[\(\)]/g, "")
            .split(",")
            .map((x) => x.trim())
            .filter((x) => x.length > 0)
    } catch {
        //todo: exception handling
    }
    return dependencies;
};

var methods = [
    "constant",
    "controller",
    "directive",
    "factory",
    "filter",
    "provider",
    "service",
    "value"
];

methods.forEach(method => {

    Module.prototype[method] = (name, fn) => {
        dependencies = extractDependenciesFromFunction(fn)
        this.items.push({
            name: name,
            dependencies: dependencies
        });
        return this;
    };
});


Module.prototype.config = () => this;

module.exports = Module;
