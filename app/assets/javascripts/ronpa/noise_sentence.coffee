#= require ronpa/sentence

class this.NoiseSentence extends Sentence
  isNoise: true
  templateId: '#noiseTemplate'

  constructor: (@content) ->
    super(@content)

  appendContent: () ->
    @content = @content.replace /[\*\[\]]/g, ''
    @element.append @content
