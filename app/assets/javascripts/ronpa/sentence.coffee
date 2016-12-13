class this.Sentence
  constructor: (@content) ->
    @element = $($(@getTemplateId()).html())
    @appendContent()
    $('body').append @element
    @randomPosition()
    @element.css('opacity', '0')

  getTemplateId: () ->
    '#sentenceTemplate'

  randomPosition: () ->
    @element.offset
      top: Math.random() * ($( document ).height() - @element.height() - 30) + 30
      left: Math.random() * ($( document ).width() - @element.width() - 300) + 300

  doAnimation: () ->
    @show()
    @move()
    @hide()

  prepare: () ->

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
        ronpa.animationEnd(that)
    )

  delete: () ->
    @element.remove()
    delete this

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
