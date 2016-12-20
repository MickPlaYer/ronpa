class this.Character
  constructor: () ->
    @element = $('#characters')
    @characters = _.map $('#characters .character'), (character) ->
      return $(character)
    @character = _.first @characters

  change: (index) ->
    return unless index
    @character.attr 'id', ''
    @character.hide()
    @character = @characters[index - 1]
    @character.attr 'id', 'character'
    @character.show()
