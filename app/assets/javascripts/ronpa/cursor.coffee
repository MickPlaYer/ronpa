class this.Cursor
  constructor: () ->
    that = this
    @cursor = $('#cursor')
    @cursor.css 'opacity', 0
    $(document).on 'mousemove', (e) ->
      that.cursor.css
         left:  e.pageX
         top:   e.pageY
    @cursor.on 'mouseleave', (e) ->
      unless e.relatedTarget is $('#characters #character')[0]
        that.cursor.clearQueue() if that.cursor.queue().length > 1
        that.cursor.animate({ opacity: 0 })
    @cursor.on 'mouseenter', (e) ->
      that.cursor.clearQueue() if that.cursor.queue().length > 1
      that.cursor.animate({ opacity: 1 })
    @cursor.on 'click', (e) ->
      that.cursor.css 'pointer-events', 'none'
      document.elementFromPoint(e.pageX, e.pageY).click();
      that.cursor.css 'pointer-events', 'all'
