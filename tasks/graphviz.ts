/*
 * grunt-graphviz
 * https://github.com/euskadi31/grunt-graphviz
 *
 * Copyright (c) 2013 Axel Etcheverry
 * Licensed under the MIT license.
 */
"use strict";
var path = require("path");

module.exports = (grunt) => {

    grunt.registerMultiTask("graphviz", "Compile DOT files", () => {

        options = this.options({
            bin: ''
        });

        # Merge task-specific and/or target-specific options with these defaults.
        compile = (src, dest, next) ->
            var processed = (err, result, code) => {
                if (err) {
                    grunt.log.error(err);
                    if (!grunt.option("force")) {
                        return false;
                    }
                } else {
                    grunt.log.writeln("Compiling " + (src).cyan + " -> " + (dest).cyan);
                }
                next();
            };

            grunt.file.mkdir(path.dirname(dest));
            var format = path.extname(dest).substr(1).toLowerCase();

            if (formats.indexOf(format) === -1) {
                grunt.log.error(`Error: format "${format}" not recognized. Use one of: $formats.join(" ")}`);
                if (!grunt.option("force")) {
                    return false;
                }
                next();
            } else {
                if ((dest !== src) && grunt.file.exists(dest)) {
                    grunt.file.delete(dest);
                }
                var cp = grunt.util.spawn({
                    cmd: options.bin + "dot",
                    args: [
                        "-T" + format,
                        src,
                        "-o",
                        dest
                    ]
                }, processed);
                if (cp && grunt.option("verbose")) {
                    cp.stdout.pipe(process.stdout);
                    cp.stderr.pipe(process.stderr);
                }
            }
            return;
        };

        var formats = "bmp canon cgimage cmap cmapx cmapx_np dot eps exr fig gd gd2 gif gv imap imap_np ismap jp2 jpe jpeg jpg pct pdf pic pict plain plain-ext png pov ps ps2 psd sgi svg svgz tga tif tiff tk vml vmlz vrml wbmp webp x11 xdot xlib".split(" ");
        grunt.verbose.writeflags(options, "Options");
        grunt.util.async.forEachLimit(@files, 30, ((file, next) => {
            compile(file.src[0], file.dest, next);
            return;
        }).bind(this), @async());
    });
};
