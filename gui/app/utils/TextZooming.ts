/// <reference path="../../../typings/jquery/jquery.d.ts"/>

$(() => {
    var w = $(window);
    var fontSizes = {
        lastIndex: 0
    };
    var ctrlActive = false;
    
    var getFontIndex = function($target) {
        var fontIndex = $target.data('index');
        if (fontIndex == null) {
            fontIndex = ++fontSizes.lastIndex;
            var currentSize = $target.css('font-size').replace('px', '');
            fontSizes[fontIndex] = parseInt(currentSize);
            $target.data('index', "" + fontIndex);
        }
        return fontIndex;
    };
    
    w.on('keydown', (e) => {
        if (e.ctrlKey && !ctrlActive) {
            ctrlActive = true;
        }
    });
    
    w.on('keyup', (e) => {
        if (ctrlActive) {
            ctrlActive = false;
        }
    });
    
    $('body').on('mousewheel', '.zoomable', (e: JQueryMouseEventObject) => {
        if (ctrlActive) {
            var $target = $(e.currentTarget);
            var fontIndex = getFontIndex($target);
            if ((<MouseWheelEvent> e.originalEvent).wheelDelta / 120 > 0) {
                $target.attr('style', 'font-size:' + (++fontSizes[fontIndex]) + 'px');
            } else {
                $target.attr('style', 'font-size:' + (--fontSizes[fontIndex]) + 'px');
            }
        }
    });
});