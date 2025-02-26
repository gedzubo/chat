class CreateChatRoomMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :chat_room_members do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :chat_room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
