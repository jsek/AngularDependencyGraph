fs = require 'node-fs'
eval fs.readFileSync('src/utils/stringUtils.js').toString()
eval fs.readFileSync('src/utils/arrayUtils.js').toString()

class App extends App
    constructor: ->
        return ['ngRoute', 'ui.bootstrap']

class AppConfig extends Config
    constructor: ->
        ErrorHandling.Message('Loading timeout', 'Initialization takes longer than expected...').ShowAfter 3500
