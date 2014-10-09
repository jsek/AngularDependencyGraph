
class App extends App
    constructor: ->
        return ['ngRoute', 'ui.bootstrap']


class AppConfig extends Config
    constructor:  ->
        setTimeout ->
            if $('.main').text() is 'Loading...'
                sweetAlert
                    type: 'warning'
                    title: 'Loading timeout'
                    text: 'Initialization takes longer than expected...'
        , 3500
