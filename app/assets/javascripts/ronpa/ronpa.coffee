#= require jquery.selection

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

class this.Ronpa
  constructor: () ->
    @sentences = []

  createSentence: (content) ->
    sentence = new Sentence(content)
    @sentences.push(sentence)
    sentence.doAnimation() if @sentences.length is 1

  animationEnd: (sentence) ->
    return if sentence.isNoise
    @sentences.shift().delete()
    @sentences[0].doAnimation() if @sentences.length > 0

this.ronpa = new Ronpa
