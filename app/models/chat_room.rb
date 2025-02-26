class ChatRoom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :chat_room_members, dependent: :destroy
  has_many :users, through: :chat_room_members
end
