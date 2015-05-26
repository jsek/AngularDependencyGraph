"use strict";
import spy = require("spy");

class FakeGrunt {
	log: { writeln }

	constructor() {
		this.log = {
			writeln: spy.on.fn()
		};
	}
}

export = FakeGrunt;