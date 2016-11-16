require 'rails_helper'

RSpec.feature "visitor can sign up", type: :feature do
  context "when the email address is valid" do
    scenario "it should take them to their dashboard" do
      visit root_path

      click_on "Sign Up"

      fill_in "Email", with: "user@example.com"
      fill_in "Password", with: "abc123"
      fill_in "Password confirmation", with: "abc123"
      click_button "Sign Up"

      expect(page).to have_content "Welcome! You have signed up successfully."
      expect(page).to have_content "You currently have no reservations."
    end
  end

  context "when the email address is invalid" do
    scenario "it should show them an error message" do
      visit root_path

      click_on "Sign Up"

      fill_in "Email", with: ""
      fill_in "Password", with: "abc123"
      fill_in "Password confirmation", with: "abc123"
      click_button "Sign Up"

      expect(page).to have_content "Email can't be blank"
    end
  end
end
