require 'rails_helper'

RSpec.describe "Ability to set the user's name", type: :feature do
  before do
    visit root_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
  end

  let(:user) { create(:user) }

  scenario "User is able to set their name if it is not set" do
    expect(page).to have_content("Please enter your name:")

    within("#intro") do
      fill_in "name", with: "Alice"
      click_on "Submit"
    end

    expect(page).to have_content("Welcome Alice (##{user.id})")
  end
end
