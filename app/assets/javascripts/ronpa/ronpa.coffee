#= require jquery.selection
#= require jquery.rotate
#= require ./logger
#= require ./poster
#= require ./sentence
#= require ./noise_sentence

that = this
$(document).on "turbolinks:load", () ->
  that.character = new Character
  that.poster = new Poster
  that.logger = new Logger
  that.cursor = new Cursor
  logger.downloadHistory()

class this.Ronpa
  constructor: () ->
    @sentences = []

  createSentence: (data) ->
    if data.tag is 'sentence'
      sentence = new Sentence(data.content, data.character)
      @sentences.push(sentence)
      sentence.doAnimation() if @sentences.length is 1
    else if data.tag is 'noise'
      noise = new NoiseSentence(data.content)
      noise.doAnimation()

  animationEnd: (sentence) ->
    return if sentence.isNoise
    @sentences.shift().delete()
    @sentences[0].doAnimation() if @sentences.length > 0

this.ronpa = new Ronpa
