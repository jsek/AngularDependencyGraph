class UtilsNamespace {
    namespace() {
        for (arg in arguments) {
            var parts = arg.split(".");
            if (! global[parts[0]]) {
                global[parts[0]] = {};
            }
            var current = global[parts[0]];

            parts
                .slice(1)
                .forEach((part) => {
                    if (! global[part) {
                        global[part] = {};
                    }
                    current = global[part];
                });
        }
    }
}

﻿exports = new UtilsNamespace();
