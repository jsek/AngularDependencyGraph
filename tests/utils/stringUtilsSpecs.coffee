if process.env.ANGULARDEPENDENCYGRAPH_COVERAGE
    require "../../src-cov/utils/utils"
else
    require "../../src/utils/utils"

testSpecialCharacter = (characters) ->
    suite = {}
    for char in characters
        if ('abc'.indexOf(char) >= 0)
            throw new Error("Invalid test case")
                
        suite["Should return true for matching #{char}abc with #{char}*"] = (test) ->
            test.equal "#{char}*".simpleMatch("#{char}abc"), true
            test.done()

        suite["Should return true for matching abc#{char} with *#{char}"] = (test) ->
            test.equal "*#{char}".simpleMatch("abc#{char}"), true
            test.done()

        suite["Should return false for matching #{char}abc with *#{char}"] = (test) ->
            test.equal "*#{char}".simpleMatch("#{char}abc"), false
            test.done()

    return suite


exports['[String Utils]'] =
    '::simpleMatch':
        'Should return true for matching ABC with A*, *A*': (test) ->
            test.equal "A*".simpleMatch("ABC"), true
            test.equal "*A*".simpleMatch("ABC"), true
            test.done()

        'Should return true for matching ABC with *C or *C*': (test) ->
            test.equal "*C".simpleMatch("ABC"), true
            test.equal "*C*".simpleMatch("ABC"), true
            test.done()

        'Should return true for matching ABC with *B*': (test) ->
            test.equal "*B*".simpleMatch("ABC"), true
            test.done()

        'Should return false for matching ABC with *CB* or *CB or CB*': (test) ->
            test.equal "CB*".simpleMatch("ABC"), false
            test.equal "*CB".simpleMatch("ABC"), false
            test.equal "*CB*".simpleMatch("ABC"), false
            test.done()

    '::simpleMatch (special characters)': 
        testSpecialCharacter ['$','^']
    
    '::contains':
        'Should return true for matching ABC in ZZZ...ABC"""': (test) ->
            test.equal 'ZZZ...ABC"""'.contains("ABC"), true
            test.done()
        'Should return false for matching ABC in KK???AB-C{}': (test) ->
            test.equal 'KK???AB-C{}'.contains("ABC"), false
            test.done()
    
    '::filename':
        'Should return document.txt for given path C:/abc/cde/document.txt': (test) ->
            test.equal 'C:/abc/cde/document.txt'.filename(), 'document.txt'
            test.done()
        'Should return document.txt for given path C:\\abc\\cde\\document.txt': (test) ->
            test.equal 'C:\\abc\\cde\\document.txt'.filename(), 'document.txt'
            test.done()
        'Should return document12.3.d.txt for given path /user/docs/document12.3.d.txt': (test) ->
            test.equal '/user/docs/document12.3.d.txt'.filename(), 'document12.3.d.txt'
            test.done()
