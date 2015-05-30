/// <reference path="system/ErrorHandler.ts"/>
/// <reference path="../../typings/angularjs/angular.d.ts"/>
/// <reference path="../../typings/node-webkit/node-webkit.d.ts"/>

var fs = require("node-fs");
eval(fs.readFileSync("src/utils/stringUtils.js").toString());
eval(fs.readFileSync("src/utils/arrayUtils.js").toString());

class App {
    constructor() {
        return [
              "ngRoute"
            , "ui.bootstrap"
            , "DWand.nw-fileDialog"
        ];
    }
}

class AppConfig {
    constructor() {
        ErrorHandling
            .Message("Loading timeout", "Initialization takes longer than expected...")
            .ShowAfter(3500);
    }
}

interface IAppConfig {
    homeDir: string,
    projectsDir: string;
}

angular
    .module("app", <string[]> new App())
    .config([AppConfig])
    .constant('config',<IAppConfig> {
        homeDir     : process.env['USERPROFILE'] + '\\AngularDependencyGraph',
        projectsDir : `${this.homeDir}\\Projects\\`

    })
