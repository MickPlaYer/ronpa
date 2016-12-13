App.ronpaChannel = App.cable.subscriptions.create "RonpaChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    switch data.type
      when 'sentence'
        ronpa.createSentence(data.content)
      when 'noise'
        noise = new NoiseSentence(data.content)
        noise.doAnimation()

  speak: ->
    data = {}
    data.content = $('#content').val()
    data.type = $('#type').val()
    return if content is ''
    $('#content').val('')
    @perform 'speak', data

this.ronpaChannel = App.ronpaChannel
