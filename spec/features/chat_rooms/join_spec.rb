require 'rails_helper'

RSpec.describe "Ability to join a chat room", type: :feature do
  before do
    log_in(user)
  end

  let(:user) { create(:user) }
  let!(:chat_room) { create(:chat_room, user: user, name: "Test Chat Room") }

  scenario "User is able to join a new chat room", js: true do
    click_on "Chat rooms"

    expect(page).to have_content("New Chat Room")

    within("#chat_room_#{chat_room.id}") do
      click_on "Join"
    end

    expect(page).to have_content("Chat room: Test Chat Room")
  end
end
