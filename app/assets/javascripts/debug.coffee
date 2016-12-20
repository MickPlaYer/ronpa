this.Debug = (key, value) ->
  @data = {} unless @data
  if key and value
    Debug[key] = value
    @data[key] = value
    console.log(value)
  else
    return @data
