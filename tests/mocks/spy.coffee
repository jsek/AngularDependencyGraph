
class Spy
    
    fakeFunction: ->
        s = =>
            @calls.push({args:arguments})
            return null
        s.calls = @calls = []
        return s
    

Spy.on =
    "function": -> (new Spy()).fakeFunction()

#    "class"   : -> (new Spy()).on.class()

module.exports = Spy