require 'rails_helper'

RSpec.describe "Ability to join a chat room", type: :feature do
  before do
    visit root_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
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
