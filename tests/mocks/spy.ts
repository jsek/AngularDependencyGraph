import FakeFunction = require("FakeFunction");

class Spy {

    fakeFunction(): FakeFunction {
        return new FakeFunction();
    }

    static on = {
        fn: (new Spy()).fakeFunction
    }
}

export = Spy;