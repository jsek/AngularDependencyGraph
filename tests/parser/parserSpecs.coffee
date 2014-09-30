grunt = require "grunt"
require "../../src/utils/utils"
FakeGrunt = require "../mocks/fake-grunt"
parser = do ->
    if process.env.ANGULARDEPENDENCYGRAPH_COVERAGE
        require "../../src-cov/parser/parser"
    else
        require "../../src/parser/parser"

exports['[Parser]'] =

    '::parsing':

        'Should return correct modules for given script1': (test) ->
            filename = 'tests/parser/_script_1_fixture.js'
            scripts = [
                { id: filename, text: grunt.file.read(filename) }
            ]
            result = parser(new FakeGrunt(), scripts, {verbose: true})

            test.equal result.count(), 1
            test.equal result[0].name, "App"
            test.equal result[0].moduleDependencies.count(), 0
            test.done()

        'Should return correct modules for given script2': (test) ->
            filename = 'tests/parser/_script_2_fixture.js'
            scripts = [
                { id: filename, text: grunt.file.read(filename) }
            ]
            result = parser(new FakeGrunt(), scripts, {verbose: true})

            test.equal result.count(), 1
            test.equal result[0].name, "MyApp"
            test.equal result[0].moduleDependencies.count(), 2
            test.done()

        'Should return empty result for given script3 cannot be evaluated': (test) ->
            filename = 'tests/parser/_script_3_fixture.js'
            scripts = [
                { id: filename, text: grunt.file.read(filename) }
            ]
            result = parser(new FakeGrunt(), scripts, {verbose: true})

            test.equal result.count(), 0
            test.done()

    '::logging':

        'Should log despite of verbose option if parsing is finished without errors': (test) ->
            filename = 'tests/parser/_script_1_fixture.js'
            scripts = [
                { id: filename, text: grunt.file.read(filename) }
            ]
            fakeGrunt1 = new FakeGrunt()
            fakeGrunt2 = new FakeGrunt()
            parser(fakeGrunt1, scripts, {verbose: false})
            parser(fakeGrunt2, scripts, {verbose: true})

            test.equal fakeGrunt1.log.writeln.calls.count(), 1
            test.equal fakeGrunt2.log.writeln.calls.count(), 1
            test.done()

        'Should log if (verbose = true) and given script cannot be evaluated': (test) ->
            filename = 'tests/parser/_script_3_fixture.js'
            scripts = [
                { id: filename, text: grunt.file.read(filename) }
            ]
            fakeGrunt = new FakeGrunt()
            parser(fakeGrunt, scripts, {verbose: true})

            test.equals fakeGrunt.log.writeln.calls.count(), 2
            test.done()

        'Should not log if (verbose = false) and given script3 cannot be evaluated': (test) ->
            filename = 'tests/parser/_script_3_fixture.js'
            scripts = [
                { id: filename, text: grunt.file.read(filename) }
            ]
            fakeGrunt = new FakeGrunt()
            parser(fakeGrunt, scripts, {verbose: false})

            test.equal fakeGrunt.log.writeln.calls.count(), 1
            test.done()
