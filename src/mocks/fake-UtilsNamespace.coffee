module.exports = ->
  Utils = {}
  Utils.namespace = ->
    len1 = arguments.length
    i = undefined
    len2 = undefined
    j = undefined
    ns = undefined
    sub = undefined
    current = undefined
    i = 0
    while i < len1
      ns = arguments[i].split(".")
      current = global[ns[0]]
      current = global[ns[0]] = {}  if current is `undefined`
      sub = ns.slice(1)
      len2 = sub.length
      j = 0
      while j < len2
        current = current[sub[j]] = current[sub[j]] or {}
        j += 1
      i += 1
    current

  Utils