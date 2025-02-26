class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :chat_room_members, dependent: :destroy
  has_many :chat_rooms, through: :chat_room_members
  has_many :messages, dependent: :destroy

  def display_name
    "#{name} (##{id})" if name.present?
  end
end
