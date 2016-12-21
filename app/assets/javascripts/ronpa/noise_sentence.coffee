#= require ronpa/sentence

class this.NoiseSentence extends Sentence
  isNoise: true
  templateId: '#noiseTemplate'

  constructor: (@content) ->
    super(@content)

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
        that.delete()
    )

  handleClick: (event) ->
    that = event.data
    that.element.clearQueue().stop()
    that.element.fadeOut 100, () ->
      that.delete()

  appendContent: () ->
    @content = @content.replace /[\*\[\]]/g, ''
    @element.append @content
