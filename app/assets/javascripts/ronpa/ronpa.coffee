#= require jquery.selection
#= require ./logger
#= require ./sentence

that = this
$(document).on "turbolinks:load", () ->
  $('#content').on 'keydown', (event) ->
    switch event.keyCode
      when 13 # Enter
        App.ronpaChannel.speak()
      when 9 # Tab
        return if $('#content').selection() is ''
        $('#content').selection('insert', { text: '*[', mode: 'before' })
        $('#content').selection('insert', { text: ']', mode: 'after' })
        event.preventDefault()
  that.logger = new Logger
  logger.downloadHistory()

class this.Ronpa
  constructor: () ->
    @sentences = []

  createSentence: (data) ->
    if data.tag is 'sentence'
      sentence = new Sentence(data.content)
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
