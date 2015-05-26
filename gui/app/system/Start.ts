/// <reference path="../../../typings/node-webkit/node-webkit.d.ts"/>
/// <reference path="../../../typings/jquery/jquery.d.ts"/>

import gui = require("nw.gui");

$(() => {
    var win = gui.Window.get();
    win.show();
    win.requestAttention(2);
});