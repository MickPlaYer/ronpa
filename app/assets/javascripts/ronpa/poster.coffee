class this.Poster
  constructor: () ->
    @element = $('#poster')
    @content = $('#content')
    @tag = $('#tag')
    @contents = []
    @setUpEvents()

  setUpEvents: () ->
    that = this
    @content.on 'keydown', (event) ->
      switch event.keyCode
        when 13 # Enter
          that.postSentence()
        when 9 # Tab
          that.colorWeakPoint()

  postSentence: () ->
    content = @content.val()
    tag = @tag.val()
    return if content is ''
    @content.val('')
    if @checkSpamming(content)
      logger.warn('Please do not spamming the channel.')
    else
      App.ronpaChannel.speak(content, tag)

  checkSpamming: (content) ->
    return true if content is _.last(@contents)
    @contents.push content
    @contents.shift() if @contents.length > 10
    result = _.countBy @contents
    return true if result[content] > 3

  colorWeakPoint: () ->
    return if @content.selection() is ''
    @content.selection('insert', { text: '*[', mode: 'before' })
    @content.selection('insert', { text: ']', mode: 'after' })
    event.preventDefault()
