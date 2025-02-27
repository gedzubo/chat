require 'rails_helper'

RSpec.describe "Ability to create a new chat room", type: :feature do
  before do
    visit root_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
  end

  let(:user) { create(:user) }

  scenario "User is able to create a new chat room", js: true do
    click_on "Chat rooms"

    expect(page).to have_content("New Chat Room")

    within("#new_chat_room_form") do
      fill_in "chat_room[name]", with: "Test Chat Room"
      click_on "Create Chat room"
    end

    within("#chat_rooms") do
      expect(page).to have_content("Test Chat Room")
    end
  end
end
