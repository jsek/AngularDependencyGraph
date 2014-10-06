class App extends App
    constructor: ->
        return ['ngRoute', 'ui.bootstrap']

class AppConfig extends Config
    constructor:  ->
        setTimeout ->
            if $('.main').text() is 'Loading...'
                swal
                    title: 'Loading timeout'
                    text: 'Looks like initialization takes longer than expected...'
                    type: 'warning'
                    button: 'OK'
        , 3500
    

