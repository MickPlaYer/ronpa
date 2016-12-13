# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class RonpaChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ronpa"
  end

  def speak data
    ActionCable.server.broadcast(
      'ronpa',
      content: data['content']
    )
  end
end
