class this.Sentence
  constructor: (@content) ->
    @element = $($('#sentenceTemplate').html())
    @appendContent()
    $('body').append @element
    @doAnimation()

  randomPosition: () ->
    @element.offset
      top: Math.random() * ($( document ).height() - @element.height())
      left: Math.random() * ($( document ).width() - @element.width() - 300) + 300

  doAnimation: () ->
    @prepare()
    @show()
    @move()
    @hide()

  prepare: () ->
    @randomPosition()
    @element.css('opacity', '0')

  show: () ->
    properties =
      opacity: 1
      left: '-=100'
    @element.animate(
      properties
      400
      'linear'
    )

  move: () ->
    properties =
      left: '-=100'
    @element.animate(
      properties
      1200
      'linear'
    )

  hide: () ->
    that = this
    properties =
      opacity: 0
      left: '-=100'
    @element.animate(
      properties
      400
      'linear'
      () ->
        that.element.hide()
    )

  appendContent: () ->
    weakPoint = /^([^\*]*)\*\[([^\]]*)\]([^\*]*)$/.exec @content
    if weakPoint
      weakPointElement = $($('#weakPointTemplate').html())
      weakPointElement.attr 'data-word', weakPoint[2]
      @element.append weakPoint[1]
      @element.append weakPointElement
      @element.append weakPoint[3]
    else
      @content = @content.replace /[\*\[\]]/g, ''
      @element.append @content
