if process.env.ANGULARDEPENDENCYGRAPH_COVERAGE
    require "../src-cov/utils/utils"
else
    require "../src/utils/utils"

exports['[Array Utils]'] =
    '::find':
        'Should return item for matching by value': (test) ->
            test.equal ["A", "B", "C"].find((x) -> x is "A"), "A"
            test.equal ["A", "B", "C"].find((x) -> x is "a"), null
            test.done()

        'Should return item for matching by property': (test) ->
            test.equal [{name:"A"}, {name:"B"}, {name:"C"}].find((x) -> x.name is "B").name, "B"
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
    
    '::count':
        'Should return correct number of items': (test) ->
            array = ["A", "B", "C"]
            test.equal array.count(), 3
            array.push("A")
            test.equal array.count(), 4
            test.equal [].count(), 0
            test.done()
