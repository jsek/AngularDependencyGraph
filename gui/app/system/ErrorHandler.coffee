class Alert
    constructor: (@title, @message) ->

    ShowAfter: (timeout) ->
        setTimeout =>
            if $('.main').text() is 'Loading...'
                sweetAlert
                    type: 'warning'
                    title: @title
                    text: @message
        , timeout
    
    #TODO: Hide

ErrorHandling =
    Message: (title, message) ->
        new Alert(title, message)