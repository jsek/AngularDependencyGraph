gui = require('nw.gui')

$ ->
    win = gui.Window.get()
    win.show()
    win.requestAttention 2