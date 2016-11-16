require 'rails_helper'

RSpec.feature "dashboard requires user to be signed in", type: :feature do
  context "when not signed in" do
    scenario "it should send them to the sign in page" do
      visit root_path

      expect(current_path).to eq(new_user_session_path)
    end
  end

  context "when signed in" do
    scenario "is should show their bookings", :wip do
      user = create(:user, password: "abc123")
      sign_in_with(user.email, "abc123")

      visit root_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content "You currently have no reservations."
    end
  end
end
