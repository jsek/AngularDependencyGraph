/// <reference path="../../../typings/angularjs/angular.d.ts"/>

class CurrentProject {
    private _current = undefined;
    private _listeners = {};

    private root        = { currentProject: {} }; // ?
    private deferred(): angular.IDeferred<any> { return null; } // ?
    private loadModel   = {}; // ?
    private reloadModel = {}; // ?

    constructor($rootScope, $q, modelLoaderService) {
        this.root = $rootScope;
        this.deferred = (): angular.IDeferred<any> => $q.defer();
        this.loadModel = () => modelLoaderService.load(this._current.options, this._current.dotPath, this._current.modelPath);
        this.reloadModel = () => modelLoaderService.reload(this._current.modelPath);
    }

    set(project) {
        if ((this._current != null ? this._current.id : void 0) === project.id) {
            return;
        }
        this._current = project;
        this.root.currentProject = project;
        this._current.whenModelReady = this.getModelPromiseFor(this.reloadModel);
        this.trigger("reset", this._current);
    }

    refresh() {
        this._current.whenModelReady = this.getModelPromiseFor(this.reloadModel);
        this.trigger("refresh", this._current);
    }

    save() {
        this._current.whenModelReady = this.getModelPromiseFor(this.loadModel);
        this.trigger("save", this._current);
        this._current.save();
    }

    getModelPromiseFor(method) {
        var d = this.deferred();
        method()
            .then(d.resolve)
            .catch(d.reject);
        return d.promise;
    }

    trigger(event, data) {
        var i, len, listener, ref, results;
        ref = this._listeners[event];
        results = [];
        for (i = 0, len = ref.length; i < len; i++) {
            listener = ref[i];
            results.push(listener(data));
        }
        return results;
    }

    on(events, fn) {
        var event, i, len, ref, results;
        ref = events.split(",");
        results = [];
        for (i = 0, len = ref.length; i < len; i++) {
            event = ref[i];
            this._listeners[event] || (this._listeners[event] = []);
            results.push(this._listeners[event].push(fn));
        }
        return results;
    }
}

angular.module("app")
.service("CurrentProject", CurrentProject);
