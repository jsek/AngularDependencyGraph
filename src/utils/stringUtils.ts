
String.prototype.filename = (): string => {
    return (<String>this).pathInCode()
        .split('/')
        .last();
};

String.prototype.pathInCode = (): string => {
    return this.replace(/\\/g, '/');
};

String.prototype.endsWith = (suffix: string): boolean => {
    return (this.lastIndexOf(suffix) + suffix.length) === this.length;
};

String.prototype.startsWith = (prefix: string): boolean => {
    return this.indexOf(prefix) === 0;
};

String.prototype.contains = (substring: string): boolean => {
    return this.indexOf(substring) >= 0;
};

// A*, *A*, *A
String.prototype.simpleMatch = (subject: string): boolean => {
    //TODO: validate expr
    var expr = this
        .replace(/\^/g, '\\^')
        .replace(/\$/g, '\\$');
    if (!expr.startsWith("*")) { expr = "^#{expr}"; }
    if (!expr.endsWith("*")) { expr = "#{expr}$"; }
    if expr.contains("*") { expr = expr.replace(/\*/g,'.*'); }

    return (new RegExp(expr)).test(subject);
};
