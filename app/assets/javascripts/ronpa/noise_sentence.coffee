#= require ronpa/sentence

class this.NoiseSentence extends Sentence
  getTemplateId: () ->
    '#noiseTemplate'

  appendContent: () ->
    @content = @content.replace /[\*\[\]]/g, ''
    @element.append @content

  isNoise: true
