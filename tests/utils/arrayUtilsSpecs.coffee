if process.env.ANGULARDEPENDENCYGRAPH_COVERAGE
    require "../../src-cov/utils/utils"
else
    require "../../src/utils/utils"

equalJSON = (test, actual, expected) ->
    test.equal JSON.stringify(actual), JSON.stringify(expected)

exports['[Array Utils]'] =
    '::find':
        'Should return item for matching by value': (test) ->
            test.equal ["A", "B", "C"].find((x) -> x is "A"), "A"
            test.equal ["A", "B", "C"].find((x) -> x is "a"), null
            test.done()

        'Should return item for matching by property': (test) ->
            equalJSON test, [{name:"A"}, {name:"B"}, {name:"C"}].find((x) -> x.name is "B"), {name:"B"}
            test.equal [{name:"A"}, {name:"B"}, {name:"C"}].find((x) -> x.name is "b"), null
            test.done()
    
    '::any':
        'Should return correct result for matching by value': (test) ->
            test.equal ["A", "B", "C"].any((x) -> x is "B"), true
            test.equal ["A", "B", "C"].any((x) -> x is "b"), false
            test.done()

        'Should return correct result for matching by property': (test) ->
            test.equal [{name:"A"}, {name:"B"}, {name:"C"}].any((x) -> x.name is "C"), true
            test.equal [{name:"A"}, {name:"B"}, {name:"C"}].any((x) -> x.name is "c"), false
            test.done()
    
    '::isEmpty':
        'Should return true only if array is empty': (test) ->
            test.equal ["A", "B", "C"].isEmpty(), false
            test.equal ["C"].isEmpty(), false
            test.equal [].isEmpty(), true
            test.done()

    '::notNull':
        'Should return array without null values': (test) ->
            equalJSON test, ["A", "A", "B", "C"].notNull(), ["A", "A", "B", "C"]
            equalJSON test, [null, "A", null, "B", "A", null, null].notNull(), ["A", "B", "A"]
            equalJSON test, [null, null].notNull(), []
            equalJSON test, [].notNull(), []
            test.done()

    '::distinct':
        'Should return distinct set of values': (test) ->
            equalJSON test, ["A", "B", "C"].distinct(), ["A", "B", "C"]
            equalJSON test, [null, "A", null, "B", null, null].distinct(), [null, "A", "B"]
            equalJSON test, [null, null].distinct(), [null]
            equalJSON test, [].distinct(), []
            equalJSON test, ["A","A","A","B","A","A","C","B","a"].distinct(), ["A", "B", "C", "a"]
            test.done()

        'Should return distinct set of values for given selector': (test) ->
            equalJSON test, ["A", "B", "C"].distinct((x) -> x isnt "C"), ["A", "C"]
            equalJSON test, [{a:""},{a:""},{a:"?"}].distinct((x) -> x.a), [{a:""},{a:"?"}]
            equalJSON test, [{a:"?"},{b:"?"}].distinct(), [{a:"?"},{b:"?"}]
            test.done()

    '::last':
        'Should return last value': (test) ->
            test.equal ["A", "B", "C"].last(), "C"
            test.equal ["A"].last(), "A"
            test.equal [].last(), null
            test.done()

    '::count':
        'Should return correct number of items': (test) ->
            array = ["A", "B", "C"]
            test.equal array.count(), 3
            test.equal array.count((x) -> x isnt "C"), 2
            array.push("A")
            test.equal array.count(), 4
            test.equal [].count(), 0
            test.equal [{a:""},{a:""},{a:"?"}].count((x) -> x.a.length > 0), 1
            test.done()

    '::ignoreScope':
        'Should return correct set of items': (test) ->
            equalJSON test, ["A", "B", "C"].ignoreScope(["A"]), ["B", "C"]
            equalJSON test, [{a:""},{a:""},{a:"?"}].ignoreScope(["\\?"], (x) -> x.a), [{a:""},{a:""}]
            test.done()

    '::applyScope':
        'Should return correct set of items': (test) ->
            equalJSON test, ["A", "B", "C"].applyScope(["A"]), ["A"]
            equalJSON test, [{a:""},{a:""},{a:"?"}].applyScope(["\\?"], (x) -> x.a), [{a:"?"}]
            test.done()
