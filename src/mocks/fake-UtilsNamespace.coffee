module.exports = function() {
    var Utils = {};

    Utils.namespace = function () {
        var len1 = arguments.length,
            i,
            len2,
            j,
            ns,
            sub,
            current;

        for (i = 0; i < len1; i += 1) {
            ns = arguments[i].split('.');
            current = global[ns[0]];
            if (current === undefined) {
                current = global[ns[0]] = {};
            }
            sub = ns.slice(1);
            len2 = sub.length;
            for (j = 0; j < len2; j += 1) {
                current = current[sub[j]] = current[sub[j]] || {};
            }
        }

        return current;
    };

    return Utils;
}