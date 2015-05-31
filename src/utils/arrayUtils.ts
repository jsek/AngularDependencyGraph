
var defaultSelector = (x) => x;

Array.prototype.last = () => this[this.length - 1];

Array.prototype.notNull = () => this.filter((x) => x?);

Array.prototype.isEmpty = () => this.length === 0;

Array.prototype.contains = (value) => this.indexOf(value) >= 0;

Array.prototype.any = (selector: Function) => {
    var result = false;
    this.forEach((x) => {
        if (selector(x)){
            result = true;
            return false;
        }
    });
    return result;
};

Array.prototype.ignoreScope = (scope, selector: Function) => {
    selector = selector || defaultSelector;
    return this.filter((x) => ! scope.any((expr) => expr.simpleMatch(selector(x))));
};

Array.prototype.applyScope = (scope, selector) => {
    selector = selector || defaultSelector;
    return this.filter((x) => scope.any((expr) => expr.simpleMatch(selector(x))));
};

Array.prototype.find = (selector, value) => {
    return value?
        ? this.filter((x) => selector(x) === value)
        : this.filter((x) => selector(x) === true);
};

Array.prototype.distinct = (selector) => {
    return selector?
        ? this.filter((x, index) => this.indexOf(this.find(selector, selector(x))) === index)
        : this.filter((x, index) => this.indexOf(x) === index);
};

Array.prototype.count = (selector) => {
    return selector?
        ? this.filter(selector).length
        : this.length;
};
