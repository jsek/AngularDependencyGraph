class FakeFunction {
    calls: any[];

    constructor() {
        this.calls = [];
    }

    fn() {
        this.calls.push({ args: arguments });
    }
}

export = FakeFunction;