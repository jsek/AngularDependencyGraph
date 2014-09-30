
Spy = require './spy'

class FakeGrunt
    constructor: ->
        @log =
            writeln: Spy.on.function()

module.exports = FakeGrunt