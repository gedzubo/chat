class Message < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user

  after_create :broadcast_message

  private

  def broadcast_message
    broadcast_append_to(
      [ chat_room, "messages" ],
      target: "messages",
      partial: "messages/message",
      locals: { message: self }
    )
  end
end
