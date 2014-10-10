# DependencyGraphGenerator

[![Build Status](https://travis-ci.org/jsek/AngularDependencyGraph.svg?branch=master)](https://travis-ci.org/jsek/AngularDependencyGraph) [![Coverage Status](https://coveralls.io/repos/jsek/AngularDependencyGraph/badge.png)](https://coveralls.io/r/jsek/AngularDependencyGraph)

### Prerequisites
* Visual Studio or WebStorm or Sublime
* Node Tools for Visual Studio (disable Intellisence if using Beta)
* Any plugin for Sass support in Visual Studio
* GraphViz extracted next to project directory (path is defined in config/Config.coffee)
* [Task Runner Explorer](http://visualstudiogallery.msdn.microsoft.com/8e1b4368-4afb-467a-bc13-9650572db708)

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
* GUI instead of current configuration with Grunt
