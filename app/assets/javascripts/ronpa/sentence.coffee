class this.Sentence
  templateId: '#sentenceTemplate'

  constructor: (@content, @character) ->
    @element = $($(@templateId).html())
    @appendContent()
    $('body').append @element
    @randomPosition()
    @element.css('opacity', '0')
    @element.on 'click', @handleClick

  handleClick: (e) ->

  randomPosition: () ->
    @element.offset
      top: Math.random() * ($( document ).height() - @element.height() - 30) + 30
      left: Math.random() * ($( document ).width() - @element.width() - 300) + 300

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
      left: '-=150'
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
