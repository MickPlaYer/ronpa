#= require ronpa/sentence

class this.NoiseSentence extends Sentence
  isNoise: true
  templateId: '#noiseTemplate'

  constructor: (@id, @content) ->
    super(@id, @content)

  handleClick: (event) ->
    that = event.data
    return if that.weakPointClick
    ronpaChannel.shoot(that.id)
    that.onShoot()

  onShoot: () ->
    that = this
    return if that.weakPointClick
    that.weakPointClick = true
    that.element.clearQueue().stop()
    that.element.fadeOut 100, () ->
      ronpa.animationEnd(that)

  appendContent: () ->
    @content = @content.replace /[\*\[\]]/g, ''
    @element.append @content
