class ChatRoom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :chat_room_members, dependent: :destroy
  has_many :users, through: :chat_room_members

  # this is the user who created the chat room
  belongs_to :user

  scope :participating, ->(user) do
    joins(:chat_room_members).where(chat_room_members: { user_id: user.id })
  end

  def member?(provided_user)
    users.include?(provided_user)
  end
end
