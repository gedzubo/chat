require 'rails_helper'

RSpec.describe "Log in", type: :feature do
  let(:user) { create(:user, name: "Alice") }
  scenario "User is able to log in" do
    visit root_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Welcome Alice (##{user.id})")
  end
end
