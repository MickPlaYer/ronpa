class this.Cursor
  constructor: () ->
    that = this
    @cursor = $('#cursor')
    @center = $('#cursor .center')
    @circle = $('#cursor .circle')
    @cursor.css 'opacity', 0
    $(document).on 'mousemove', (e) ->
      that.cursor.css
         left:  e.pageX
         top:   e.pageY
      that.center.css
         left:  e.pageX - 25
         top:   e.pageY - 25
      that.circle.css
         left:  e.pageX - 43
         top:   e.pageY - 43
    @cursor.on 'mouseleave', (e) ->
      unless e.relatedTarget is $('#characters #character')[0]
        that.cursor.clearQueue() if that.cursor.queue().length > 1
        that.cursor.animate({ opacity: 0 })
    @cursor.on 'mouseenter', (e) ->
      that.cursor.clearQueue() if that.cursor.queue().length > 1
      that.cursor.animate({ opacity: 1 })
    @cursor.on 'click', (e) ->
      that.cursor.css 'pointer-events', 'none'
      element = document.elementFromPoint(e.pageX, e.pageY)
      element.click()
      that.cursor.css 'pointer-events', 'all'

  rotateCircle: () ->
    cursor.circle.rotate
      angle: 0
      animateTo: 360
      duration: 2000
      callback: cursor.rotateCircle
      easing: (x, t, b, c, d) ->
        return c * (t / d) + b
