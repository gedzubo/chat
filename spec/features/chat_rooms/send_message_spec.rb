require 'rails_helper'

RSpec.describe "Ability to send messages inside the chat room", type: :feature do
  before do
    log_in(user)

    chat_room.users << user
  end

  let(:user) { create(:user, name: "Gee") }
  let!(:chat_room) { create(:chat_room, user: user, name: "Test Chat Room") }

  scenario "User is able to send a message", js: true do
    click_on "Chat rooms"

    expect(page).to have_content("New Chat Room")

    within("#chat_room_#{chat_room.id}") do
      click_on "View"
    end

    within("#new_message") do
      fill_in "message[body]", with: "Hello World!"
      click_on "Send"
    end

    within("#messages") do
      expect(page).to have_content("Gee: Hello World!")
    end
  end
end
