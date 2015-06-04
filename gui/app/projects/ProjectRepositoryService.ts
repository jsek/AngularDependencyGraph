/// <reference path="../../../typings/angularjs/angular.d.ts"/>
/// <reference path="./ProjectModel.ts"/>

var fs = require('node-fs');
import { IProject, Project } from "./ProjectModel";

export interface IProjectRepository {
    getProjects(): Array<IProject>;
    add(project: IProject);
    on(events: string, fn: Function);
    trigger(eventName: string, data: any);
}

export class ProjectRepository implements IProjectRepository {

    public projects = [];
    private _listeners = {};

    constructor(config: IAppConfig) {

        if (!fs.existsSync(config.projectsDir)) {
            fs.mkdirSync(config.homeDir);
            fs.mkdirSync(config.projectsDir);
        }

        fs.readdir(config.projectsDir, (err, files) => {
            if (err) {
                console.error(err);
            } else {
                for (name in files) {
                    // dirty
                    if (fs.existsSync (config.projectsDir + name)) {
                        this.add(new Project(name));
                    }
                }
            }
        });
    }

    getProjects() {
        return this.projects.slice();
    }

    add(project) {
        this.projects.push(project);
        this.trigger('add', project);
        console.log("New Project: #{project.name}");
        console.log(this._listeners);
    }

    trigger(eventName, data) {
        for (var listener in this._listeners[eventName]) {
            listener(data);
        }
    }

    on(events, fn) {
        for (var event in events.split(',')) {
            if (! this._listeners[event]) {
                this._listeners[event] = [];
            }
            this._listeners[event].push(fn);
        }
    }
}

angular.module('app')
.service('projectRepositoryService', ProjectRepository);