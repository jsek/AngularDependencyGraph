
String::filename = ->
    @replace(/\\/g, '/')
    .split('/')
    .last()

String::endsWith = (suffix) ->
    @lastIndexOf(suffix) + suffix.length is @length

String::startsWith = (prefix) ->
    @indexOf(prefix) is 0

String::contains = (substring) ->
    @indexOf(substring) >= 0

# A*, *A*, *A
String::simpleMatch = (subject) ->
    #TODO: validate expr
    expr = @
        .replace(/\^/g, '\\^')
        .replace(/\$/g, '\\$')
    expr = "^#{expr}"  unless expr.startsWith "*"
    expr = "#{expr}$"  unless expr.endsWith "*"
    expr = expr.replace(/\*/g,'.*')  if expr.contains "*"

    (new RegExp(expr)).test subject