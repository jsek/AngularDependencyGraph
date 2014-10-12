# https://github.com/DWand/nw-fileDialog
# * This program is free software. It comes without any warranty, to
# * the extent permitted by applicable law. You can redistribute it
# * and/or modify it under the terms of the Do What The Fuck You Want
# * To Public License, Version 2, as published by Sam Hocevar. See
# * http://www.wtfpl.net/ for more details. 
angular.module("DWand.nw-fileDialog", []).factory "fileDialog", ->
    callDialog = (dialog, callback) ->
        dialog.addEventListener "change", ->
            result = dialog.value
            callback result
        , false
        dialog.click()

    dialogs = {}
    dialogs.saveAs = (callback, defaultFilename, acceptTypes) ->
        dialog = document.createElement("input")
        dialog.type = "file"
        dialog.nwsaveas = defaultFilename or ""
        if angular.isArray(acceptTypes)
            dialog.accept = acceptTypes.join(",")
        else dialog.accept = acceptTypes    if angular.isString(acceptTypes)
        callDialog dialog, callback

    dialogs.openFile = (callback, multiple, acceptTypes) ->
        dialog = document.createElement("input")
        dialog.type = "file"
        dialog.multiple = "multiple"    if multiple is true
        if angular.isArray(acceptTypes)
            dialog.accept = acceptTypes.join(",")
        else dialog.accept = acceptTypes    if angular.isString(acceptTypes)
        callDialog dialog, callback

    dialogs.openDir = (callback) ->
        dialog = document.createElement("input")
        dialog.type = "file"
        dialog.nwdirectory = "nwdirectory"
        callDialog dialog, callback

    dialogs