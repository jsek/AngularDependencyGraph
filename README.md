﻿# DependencyGraphGenerator

[![Build Status](https://travis-ci.org/jsek/AngularDependencyGraph.svg?branch=master)](https://travis-ci.org/jsek/AngularDependencyGraph) [![Coverage Status](https://coveralls.io/repos/jsek/AngularDependencyGraph/badge.png)](https://coveralls.io/r/jsek/AngularDependencyGraph)

### Prerequisites
* Grunt and Gulp (yep, both are used)
* Visual Studio or WebStorm or Sublime
* Node Tools for Visual Studio (disable Intellisence if using Beta)
* Any plugin for Sass support in Visual Studio
* GraphViz extracted next to project directory (path is defined in config/Config.coffee)
* [Task Runner Explorer](http://visualstudiogallery.msdn.microsoft.com/8e1b4368-4afb-467a-bc13-9650572db708)

### Workflow

First things first
    
	npm install -g grunt grunt-cli gulp bower
	npm install
	grunt build

Preview (compile + build + run)

	gulp

#### Development workflow: frontend

	gulp watch
    
...and simply run `gulp debug` to build and run *(this is not real debugging, sorry)*

(I wish I could just create an archive and run nw.exe, but this didn't work)

#### Development workflow: backend

	grunt watch
    
...and simply run `grunt` to run

Use `run.js` to debug backend or run GUI with just `F5` (in Visual Studio) 

---

### Goals
* ~100% Code coverage (at Coveralls.io)
* Passing build on TravisCI (or other CI)
* Easy development with Grunt or Gulp

### Architecture
* Modular architecture based on node.js modules
* Extendability architecture based on plugins that can be written outside the core
* Open for future changes towards simulations with interactive graph and high-level analysis of components weight

### Road Map
* ( ✓ ) *Work as Grunt task (so that can be run automatically after build)*
* Interactive graph generation with D3.js (instead of Graphviz)
* Statistics for selected nodes

#### Nice to have
* ( in progress ) GUI instead of current configuration with Grunt
