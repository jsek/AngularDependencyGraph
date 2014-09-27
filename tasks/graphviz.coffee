#
# * grunt-graphviz
# * https://github.com/euskadi31/grunt-graphviz
# *
# * Copyright (c) 2013 Axel Etcheverry
# * Licensed under the MIT license.
# 
"use strict"
config = require("../config/Config")
path = require("path")
    
module.exports = (grunt) ->
    
    grunt.registerMultiTask "graphviz", "Compile DOT files", ->
        
        # Merge task-specific and/or target-specific options with these defaults.
        compile = (src, dest, next) ->
            processed = (err, result, code) ->
                if err
                    grunt.log.error err
                    return false    unless grunt.option("force")
                else
                    grunt.log.writeln "Compiling " + (src).cyan + " -> " + (dest).cyan
                next()

            cp = undefined
            grunt.file.mkdir path.dirname(dest)
            format = path.extname(dest).substr(1).toLowerCase()

            if formats.indexOf(format) is -1
                grunt.log.error "Error: format \"" + format + "\" not recognized. Use one of: " + formats.join(" ")
                return false    unless grunt.option("force")
                next()
            else
                grunt.file.delete dest    if dest isnt src and grunt.file.exists(dest)
                cp = grunt.util.spawn(
                    cmd: config.path.GRAPHVIZ + "dot"
                    args: [
                        "-T" + format
                        src
                        "-o"
                        dest
                    ]
                , processed)
                if cp and grunt.option("verbose")
                    cp.stdout.pipe process.stdout
                    cp.stderr.pipe process.stderr
            return

        options = @options()
        formats = "bmp canon cgimage cmap cmapx cmapx_np dot eps exr fig gd gd2 gif gv imap imap_np ismap jp2 jpe jpeg jpg pct pdf pic pict plain plain-ext png pov ps ps2 psd sgi svg svgz tga tif tiff tk vml vmlz vrml wbmp webp x11 xdot xlib".split(" ")
        grunt.verbose.writeflags options, "Options"
        grunt.util.async.forEachLimit @files, 30, ((file, next) ->
            compile file.src[0], file.dest, next
            return
        ).bind(this), @async()