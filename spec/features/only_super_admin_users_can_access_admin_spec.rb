require 'rails_helper'

RSpec.feature "only super admin users can access the admin", type: :feature do
  let(:user) { create(:user) }

  context "user is a super admin" do
    scenario "they should see the admin dashboard" do
      role = create(:role, name: "Super Admin")
      user.roles << role

      sign_in_with(user.email, "abc123")

      visit admin_root_path

      expect(page).to have_content "Dashboard"
    end
  end

  context "user is not a super admin" do
    scenario "is should show their bookings", :wip do
      sign_in_with(user.email, "abc123")

      visit admin_root_path

      expect(page).to have_content "You are not authorized to access this resource!"
    end
  end
end
