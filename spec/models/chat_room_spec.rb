require 'rails_helper'

RSpec.describe ChatRoom, type: :model do
  describe "#member?" do
    let(:chat_room) { create(:chat_room, user: user) }
    let(:user) { create(:user) }

    context "when the user is a member of the chat room" do
      before do
        chat_room.users << user
      end

      it "returns true" do
        expect(chat_room.member?(user)).to be_truthy
      end
    end

    context "when the user is not a member of the chat room" do
      it "returns false" do
        expect(chat_room.member?(user)).to be_falsey
      end
    end
  end
end
