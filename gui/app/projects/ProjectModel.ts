/// <reference path="../../../typings/sweetalert/sweetalert.d.ts"/>
/// <reference path="../../../typings/node-webkit/node-webkit.d.ts"/>

var fs = require('node-fs');

export interface IProject {
    id: number;
    name: string;
    path: string;
    options: Options;
    save();
    createProjectDir();
    loadOptions();
}

export class Project implements IProject {
    private __id = 1;
    private _dotFilename = 'model.dot';
    private _modelFilename = 'model.json';
    private _configFilename = 'config.json';

    public id : number;
    public name : string;
    public path : string;
    public options : Options;
    public configPath : string;
    public dotPath : string;
    public modelPath : string;

    constructor(name: string, options?: any) {
        this.id = this.__id++;
        this.name = name;
        this.path = global.projectsDir + name;
        this.options = new Options(options);
        this.dotPath = this.path + '\\' + this._dotFilename;
        this.modelPath = this.path + '\\' + this._modelFilename;
        this.configPath = this.path + '\\' + this._configFilename;

        if (!fs.existsSync(this.path)) {
            this.createProjectDir();
        } else {
            this.loadOptions();
        }
    }

    save() {
        fs.writeFile(this.configPath, JSON.stringify(this.options));
    }

    createProjectDir() {
        fs.mkdir(this.path, (err) => {
            if (err) {
                swal({
                    title: 'Warning',
                    text: "We cannot create project directory (#{this.path})",
                    type: 'error'
                });
            } else {
                this.save();
            }
        });
    }

    loadOptions() {
        if (fs.existsSync(this.configPath)) {
            var optionsText = fs.readFileSync(this.configPath);
            this.options = new Options(JSON.parse(optionsText.toString()));
        }
    }
}

class Options {

    private static _defaults: any = {
        files: [],
        showEmptyItems: false,
        json: true,
        verbose: false,
        colors: {
            externalDependencies: 'red'
        },
        ignore: [],
        rootModule: undefined,
        levelLimit: {
            above: undefined,
            below: undefined
        }
    }

    constructor(options = {}) {
        for (var key of Options._defaults) {
            this[key] = options[key] || Options._defaults[key];
        }
    }
}