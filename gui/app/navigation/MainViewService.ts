/// <reference path="../../../typings/angularjs/angular.d.ts"/>
/// <reference path="../../../typings/jquery/jquery.d.ts"/>

var jade = require('jade');

class MainViewService {

    private _history = [];
    private _templates = [];
    private _wasAlreadySet = false;
    private _shadowDOM = $('<div>');
    
    private _compilator = () => {};

    private _listeners = {};

    private viewsRootDirectory = 'gui/views/';
    
    public container: JQuery;
    public sidebar: JQuery;
    public defaultScope: ng.IRootScopeService;
    
    protected currentTemplate;
    
    constructor($compile, $rootScope) {
        this._compilator = $compile;
        this.container = $('.main');
        this.sidebar = $('.sidebar');
        this._shadowDOM.insertBefore(this.container).hide();
        this.defaultScope = $rootScope;   
    }
                
    set(filename, $scope?, ignoreHistory? = false) {

        if (!ignoreHistory) {
            this._history.push(filename);
        }

        this.currentTemplate = filename;

        this.trigger('change', filename)

        if (this._templates[filename]?) {
            this.container.children().detach().appendTo(this._shadowDOM);
            this._shadowDOM.children("[data-template='#{filename}']").detach().appendTo(this.container);
            this._wasAlreadySet = true;
        } else {
            var template = jade.compileFile(this.viewsRootDirectory + filename);
            var compiledHTML = this._compilator(template())($scope || this.defaultScope)
            
            var newContent = $("<div data-template='#{filename}'></div>");
            newContent.html(compiledHTML);

            this.container.children().detach().appendTo(this._shadowDOM);
            this.container.append(newContent);

            this._templates[filename] = newContent
            this._wasAlreadySet = false;
        }
    }

    find(selector) {
        this.container.find(selector);
    }

    wasAlreadySet() { 
        return this._wasAlreadySet; 
    }
        
    back() {
        this._history.pop();
        this.set(this._history.last(), null, true);
    }

    expand() {
        this.sidebar.addClass('slide-out');
        this.container.addClass('expanded');
    }
    
    collapse() {
        this.sidebar.removeClass('slide-out');
        this.container.removeClass('expanded');
    }

    trigger(event, data) {
        for (var listener of this._listeners[event]) {
            listener(data)
        } 
    }

    on(events, fn) {
        for (event of events.split(',')) {
            this._listeners[event] = this._listeners[event] || []
            this._listeners[event].push(fn);
        }
    } 

}

angular.module('app')
.service('mainViewService', MainViewService);