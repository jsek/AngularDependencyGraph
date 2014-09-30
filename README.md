# DependencyGraphGenerator

[![Build Status](https://travis-ci.org/jsek/AngularDependencyGraph.svg?branch=master)](https://travis-ci.org/jsek/AngularDependencyGraph) [![Coverage Status](https://coveralls.io/repos/jsek/AngularDependencyGraph/badge.png)](https://coveralls.io/r/jsek/AngularDependencyGraph)

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
