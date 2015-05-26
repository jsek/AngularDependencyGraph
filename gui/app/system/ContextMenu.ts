/// <reference path="../../../typings/node-webkit/node-webkit.d.ts"/>
/// <reference path="../../../typings/jquery/jquery.d.ts"/>

import gui = require('nw.gui');

$(() => {
    var win = gui.Window.get()
    var menu = new gui.Menu()
    menu.append(new gui.MenuItem({ label: 'Dev Tools', click: () => win.showDevTools() }))

    document.addEventListener('contextmenu', (e: MouseEvent) => { 
        e.preventDefault();
        menu.popup(e.x, e.y);
        return false;
    });

    document.addEventListener('keyup', (e: KeyboardEvent) => { 
//        if ((e.keyIdentifier === 'F12') || (e.keyCode === 74 && e.shiftKey && e.ctrlKey))
            win.showDevTools();
    });           
});