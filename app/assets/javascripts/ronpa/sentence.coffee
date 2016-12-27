class this.Sentence
  templateId: '#sentenceTemplate'
  weakPointClick: false

  constructor: (@content, @character) ->
    @element = $($(@templateId).html())
    @element.on 'click', this, @handleClick
    @appendContent()
    $('body').append @element
    @randomPosition()
    @element.css('opacity', '0')

  handleClick: (event) ->
    that = event.data
    return if that.weakPointClick
    that.element.css('color', 'red')
    setTimeout(
      () ->
        that.element.css('color', 'white')
      100
    )

  handleWeakPointClick: (event) ->
    that = event.data
    that.weakPointClick = true
    that.element.clearQueue().stop()
    that.element.rotate
      angle: 0
      animateTo: 360 * 3
      duration: 1000
      easing: (x, t, b, c, d) ->
        return c * (t / d) + b
    that.element.fadeOut 500, () ->
      that.element.hide()
      ronpa.animationEnd(that)

  randomPosition: () ->
    horizonMove = 75 + 150 + 75
    horizonRange = $(document).width() - @element.width() - horizonMove
    verticalRange = $(document).height() - @element.height() - 30
    @element.offset
      top: Math.random() * verticalRange + 30
      left: Math.random() * horizonRange + horizonMove

  doAnimation: () ->
    @show()
    @move()
    @hide()

  show: () ->
    character.change(@character)
    properties =
      opacity: 1
      left: '-=75'
    @element.animate(
      properties
      300
      'linear'
    )

  move: () ->
    properties =
      left: "-=150"
    @element.animate(
      properties
      2000
      'linear'
    )

  hide: () ->
    that = this
    properties =
      opacity: 0
      left: '-=75'
    @element.animate(
      properties
      300
      'linear'
      () ->
        that.element.hide()
        ronpa.animationEnd(that)
    )

  delete: () ->
    @element.remove()
    delete this

  appendContent: () ->
    words = /^([^\*]*)\*\[([^\]]*)\]([^\*]*)$/.exec @content
    if words
      @weakPoint = @createWeakPoint words[2]
      @element.append words[1]
      @element.append @weakPoint
      @element.append words[3]
    else
      @content = @content.replace /[\*\[\]]/g, ''
      @element.append @content

  createWeakPoint: (word) ->
    that = this
    weakPoint = $($('#weakPointTemplate').html())
    weakPoint.attr 'data-word', word
    weakPoint.on 'click', this, @handleWeakPointClick
    return weakPoint
