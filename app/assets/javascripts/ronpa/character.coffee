class this.Character
  constructor: () ->
    @element = $('#characters')
    @characters = _.map $('#characters .character'), (character) ->
      return $(character)

  change: (index) ->
    return unless index
    for character in @characters
      character.hide()
    @characters[index - 1].show()
