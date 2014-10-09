gui = require('nw.gui')

$ ->
    win = gui.Window.get()
    menu = new gui.Menu()
    menu.append(new gui.MenuItem({ label: 'Dev Tools', click: -> win.showDevTools() }))

    document.addEventListener 'contextmenu', (e) -> 
        e.preventDefault()
        menu.popup e.x, e.y
        return false