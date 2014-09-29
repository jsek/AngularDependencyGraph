module.exports = 
    namespace: ->
        for arg in arguments
            parts = arg.split "."
            current = global[parts[0]] or= {}

            for part in parts[1..]
                current = global[part] or= {}