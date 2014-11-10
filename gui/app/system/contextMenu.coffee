gui = require 'nw.gui'

$ ->
    win = gui.Window.get()
    menu = new gui.Menu()
    menu.append(new gui.MenuItem({ label: 'Dev Tools', click: -> win.showDevTools() }))

    document.addEventListener 'contextmenu', (e) -> 
        e.preventDefault()
        menu.popup e.x, e.y
        return false

    document.addEventListener 'keyup', (e) -> 
        if (e.keyIdentifier is 'F12') or (e.keyCode is 74 and e.shiftKey and e.ctrlKey)
            win.showDevTools()