#= require ronpa/sentence

class this.NoiseSentence extends Sentence
  isNoise: true
  templateId: '#noiseTemplate'

  appendContent: () ->
    @content = @content.replace /[\*\[\]]/g, ''
    @element.append @content
