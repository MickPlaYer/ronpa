class this.Poster
  constructor: () ->
    @element = $('#poster')
    @characterButton = $('#poster #characterButton')
    @characterSelector = $('#poster #characterSelector')
    @content = $('#poster #content')
    @tag = $('#poster #tag')
    @character = $('#poster #character')
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
    @characterButton.on 'click', () ->
      that.characterSelector.fadeIn()
    @tag.on 'change', (event) ->
      if that.tag.val() is 'noise'
        that.characterButton.hide()
        that.characterSelector.fadeOut()
      else
        that.characterButton.show()
    @character.imagepicker(
      selected: () ->
        that.characterSelector.fadeOut()
    )

  postSentence: () ->
    content = @content.val()
    return if content is ''
    @content.val('')
    tag = @tag.val()
    if tag is 'sentence'
      character = @character.val()
      isSpamming = @checkSpamming(content)
    if isSpamming
      logger.warn('Please do not spamming the channel.')
    else
      App.ronpaChannel.speak(content, tag, character)

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
