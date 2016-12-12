class this.Ronpa
  createSentebce: () ->
    return if content == ''
    content = $('#content').val()
    $('#content').val('');
    new Sentence(content)

this.ronpa = new Ronpa
