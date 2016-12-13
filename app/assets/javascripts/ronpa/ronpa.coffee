$(document).on "turbolinks:load", () ->
  $('#content').on 'keydown', (event) ->
    if event.keyCode == 13 # Enter
      App.ronpa.speak()

class this.Ronpa
  createSentebce: () ->
    content = $('#content').val()
    return if content == ''
    $('#content').val('')
    new Sentence(content)

this.ronpa = new Ronpa
