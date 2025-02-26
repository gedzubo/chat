require 'rails_helper'

RSpec.describe "Ability to set the user's name", type: :feature do
  let(:user) { create(:user) }

  before do
    sign_in user
    visit root_path
  end

  scenario "User is able to set their name if it is not set" do
    expect(page).to have_content("Please enter your name:qqq")

    within("#intro") do
      fill_in ".name", with: "Alice"
      click_on "Submit"
    end

    expect(page).to have_content("Welcome Alice ##{user.id}")
  end
end
