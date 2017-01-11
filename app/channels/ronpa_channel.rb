# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class RonpaChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ronpa"
  end

  def speak data
    tag = Sentence.tags[data['tag']]
    content = data['content']
    @sentence = Sentence.create!(:content => content, :tag => tag)
    sentence = @sentence.as_json
    sentence['character'] = data['character'] if @sentence.sentence?
    ActionCable.server.broadcast(
      'ronpa',
      { sentence: sentence, type: 'speak'}
    )
  end

  def shoot data
    ActionCable.server.broadcast(
      'ronpa',
      { id: data['id'], type: 'shoot'}
    )
  end
end
