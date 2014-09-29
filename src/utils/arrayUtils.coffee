
defaultSelector = (x) -> x

Array::last = -> this[@length - 1]

Array::notNull = -> x for x in @ when x?

Array::isEmpty = -> @length is 0

Array::contains = (value) -> 
    @.indexOf(value) >= 0

Array::any = (selector) -> 
    for x in @ when selector(x)
        return x

Array::ignoreScope = (scope, selector) ->
    selector = selector or defaultSelector
    x for x in @ when not scope.any (expr) -> expr.simpleMatch(selector(x))

Array::applyScope = (scope, selector) ->
    selector = selector or defaultSelector
    x for x in @ when scope.any (expr) -> expr.simpleMatch(selector(x))

Array::find = (selector) ->
    for x in @ when selector(x)
        return x
    return null

Array::distinct = (selector) ->
    if selector?
        x for x, index in @ when (@indexOf(@find(selector, selector(x))) is index)
    else
        x for x, index in @ when (@indexOf(x) is index)

Array::count = (selector) ->
    if selector?
        @.filter(selector).length
    else
        @.length
