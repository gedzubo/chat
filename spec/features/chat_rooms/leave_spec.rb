require 'rails_helper'

RSpec.describe "Ability to leave a chat room", type: :feature do
  before do
    log_in(user)

    chat_room.users << user
  end

  let(:user) { create(:user) }
  let!(:chat_room) { create(:chat_room, user: user, name: "Test Chat Room") }

  scenario "User is able to leave a new chat room", js: true do
    click_on "Chat rooms"

    expect(page).to have_content("New Chat Room")

    within("#chat_room_#{chat_room.id}") do
      click_on "Leave"
    end

    within("#chat_room_#{chat_room.id}") do
      expect(page).to have_content("Join")
    end
  end
end
