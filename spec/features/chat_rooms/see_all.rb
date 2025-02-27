require 'rails_helper'

RSpec.describe "Ability to see the list of chat rooms", type: :feature do
  before do
    visit root_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
  end

  let(:user) { create(:user) }
  let!(:chat_room) { create(:chat_room, user: user, name: "Test Chat Room") }

  scenario "User is able to see chat rooms" do
    click_on "Chat rooms"

    within("#chat_rooms") do
      expect(page).to have_content("Test Chat Room")
    end
  end
end
