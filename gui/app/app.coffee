
# TODO: Global Exception Handler
# How to intercept error handler in Chromium ?
safeExec = (fn) ->
    try
        fn()
    catch
        swal
            title: 'Global Exception Handler'
            text: 'Looks like we messed up...'
            type: 'Error'

window.onload = ->

    gui = require('nw.gui')
    win = gui.Window.get()
    win.show()
    
    menu = new gui.Menu()
    menu.append(new gui.MenuItem({ label: 'Dev Tools', click: -> win.showDevTools() }))

    document.addEventListener 'contextmenu', (e) -> 
        e.preventDefault()
        menu.popup e.x, e.y
        return false


class App extends App
    constructor: ->
        return ['ngRoute', 'ui.bootstrap']

class AppConfig extends Config
    constructor:  ->
        setTimeout ->
            if $('.main').text() is 'Loading...'
                swal
                    title: 'Loading timeout'
                    text: 'Looks like initialization takes longer than expected...'
                    type: 'warning'
                    button: 'OK'
        , 3500
