$ ->
    w = $(window)
    fontSizes = { lastIndex: 0 }
    ctrlActive = false

    getFontIndex = ($target) ->
        fontIndex = $target.data 'index'
        unless fontIndex?
            fontIndex = ++fontSizes.lastIndex
            currentSize = $target.css('font-size').replace('px','')
            fontSizes[fontIndex] = parseInt(currentSize)
            $target.data 'index', "#{fontIndex}"

        return fontIndex

    w.on 'keydown', (e) -> if (e.ctrlKey and not ctrlActive) then ctrlActive = true
    w.on 'keyup',   (e) -> if (ctrlActive)                   then ctrlActive = false

    $('body').on 'mousewheel', '.zoomable', (e) ->
        if ctrlActive
            $target = $(e.currentTarget)
            fontIndex = getFontIndex $target

            if (e.originalEvent.wheelDelta / 120 > 0)
                $target.attr 'style', 'font-size:' + (++fontSizes[fontIndex]) + 'px'
            else
                $target.attr 'style', 'font-size:' + (--fontSizes[fontIndex]) + 'px'
