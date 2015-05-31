/// <reference path="/typings/gruntjs/gruntjs.d.ts"/>
"use strict";

require("../../src/utils/utils");

import grunt = require("grunt");
var FakeGrunt = require("../mocks/FakeGrunt.ts");

var parser = (process.env.ANGULARDEPENDENCYGRAPH_COVERAGE)
    ? require("../../src-cov/parser/parser")
    : require("../../src/parser/parser");

exports["[Parser]"] = {
    '::parsing': {
        'Should return correct modules for given script1': test => {
            var filename = "tests/parser/_script_1_fixture.js";
            var scripts = [
                {
                    id: filename,
                    text: grunt.file.read(filename)
                }
            ];
            var result = parser(new FakeGrunt(), scripts, {
                verbose: true
            });
            test.equal(result.count(), 1);
            test.equal(result[0].name, "App");
            test.equal(result[0].moduleDependencies.count(), 0);
            return test.done();
        },
        'Should return correct modules for given script2': test => {
            var filename = "tests/parser/_script_2_fixture.js";
            var scripts = [
                {
                    id: filename,
                    text: grunt.file.read(filename)
                }
            ];
            var result = parser(new FakeGrunt(), scripts, {
                verbose: true
            });
            test.equal(result.count(), 1);
            test.equal(result[0].name, "MyApp");
            test.equal(result[0].moduleDependencies.count(), 2);
            return test.done();
        },
        'Should return empty result for given script3 cannot be evaluated': test => {
            var filename = "tests/parser/_script_3_fixture.js";
            var scripts = [
                {
                    id: filename,
                    text: grunt.file.read(filename)
                }
            ];
            var result = parser(new FakeGrunt(), scripts, {
                verbose: true
            });
            test.equal(result.count(), 0);
            return test.done();
        }
    },
    '::logging': {
        'Should log despite of verbose option if parsing is finished without errors': test => {
            var filename = "tests/parser/_script_1_fixture.js";
            var scripts = [
                {
                    id: filename,
                    text: grunt.file.read(filename)
                }
            ];
            var fakeGrunt1 = new FakeGrunt();
            var fakeGrunt2 = new FakeGrunt();
            parser(fakeGrunt1, scripts, {
                verbose: false
            });
            parser(fakeGrunt2, scripts, {
                verbose: true
            });
            test.equal(fakeGrunt1.log.writeln.calls.count(), 1);
            test.equal(fakeGrunt2.log.writeln.calls.count(), 1);
            return test.done();
        },
        'Should log if (verbose = true) and given script cannot be evaluated': test => {
			var filename = "tests/parser/_script_3_fixture.js";
			var scripts = [
                {
                    id: filename,
                    text: grunt.file.read(filename)
                }
            ];
			var fakeGrunt = new FakeGrunt();
            parser(fakeGrunt, scripts, {
                verbose: true
            });
            test.equals(fakeGrunt.log.writeln.calls.count(), 2);
            return test.done();
        },
        'Should not log if (verbose = false) and given script3 cannot be evaluated': test => {
			var filename = "tests/parser/_script_3_fixture.js";
			var scripts = [
                {
                    id: filename,
                    text: grunt.file.read(filename)
                }
            ];
			var fakeGrunt = new FakeGrunt();
            parser(fakeGrunt, scripts, {
                verbose: false
            });
            test.equal(fakeGrunt.log.writeln.calls.count(), 1);
            return test.done();
        }
    }
};
