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
  cursor.rotateCircle()
  logger.downloadHistory()

class this.Ronpa
  constructor: () ->
    @sentences = []
    @noises = []

  createSentence: (data) ->
    if data.tag is 'sentence'
      sentence = new Sentence(data.id, data.content, data.character)
      @sentences.push(sentence)
      sentence.doAnimation() if @sentences.length is 1
    else if data.tag is 'noise'
      noise = new NoiseSentence(data.id, data.content)
      @noises.push(noise)
      noise.doAnimation()

  animationEnd: (sentence) ->
    if sentence.isNoise
      index = _.findIndex(@noises, { id: sentence.id })
      noise = @noises.splice(index, 1)[0] unless index is -1
      noise.delete()
    else
      @sentences.shift().delete()
      @sentences[0].doAnimation() if @sentences.length > 0

  shoot: (id) ->
    index = _.findIndex(@noises, { id: id })
    @noises[index].onShoot() unless index is -1
    if index is -1
      index = _.findIndex(@sentences, { id: id })
      @sentences[index].onShoot() unless index is -1

this.ronpa = new Ronpa
