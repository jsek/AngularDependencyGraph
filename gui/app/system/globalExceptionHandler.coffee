
# Global Exception Handler
process.on 'uncaughtException', (err) ->
    console.warn 'Uncaught exception: ' + err
    sweetAlert
        title: 'Looks like we messed up... :('
        text: 'See exception details in [DevTools] > [Console]'