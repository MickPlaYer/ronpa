App.ronpa = App.cable.subscriptions.create "RonpaChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    content = data.content
    new Sentence(content)

  speak: ->
    content = $('#content').val()
    return if content == ''
    $('#content').val('')
    @perform 'speak', content: content
