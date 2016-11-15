require 'rails_helper'

RSpec.feature "user can create a new booking", type: :feature do
  let(:email) { Faker::Internet.email }
  let(:password) { "abc123" }
  let!(:user) { User.create(email: email, password: password, password_confirmation: password) }
  let!(:hotel) { create(:hotel, name: "Four Seasons") }
  let!(:room_type) { create(:room_type, name: "Presidential Suite") }
  let!(:room) { create(:room, hotel: hotel, room_type: room_type) }
  let(:check_in) { Time.now.to_date }
  let(:check_out) { 3.days.from_now.to_date }

  context "invalid booking information" do
    scenario "should see an error message", :js do
      sign_in_with(email, password)

      click_on "New Booking"

      select "Four Seasons", from: "Hotel"

      sleep 1

      select "Presidential Suite", from: "Room Type"
      fill_in "Description", with: "Vacation!"

      click_button "Book It!"

      expect(page).to have_content "Check in can't be blank"
      expect(page).to have_content "Check out can't be blank"
    end
  end

  context "no existing bookings" do
    scenario "should see booking on their dashboard", :js do
      sign_in_with(email, password)

      click_on "New Booking"

      fill_in "Check In", with: check_in
      fill_in "Check Out", with: check_out
      select "Four Seasons", from: "Hotel"

      sleep 1

      select "Presidential Suite", from: "Room Type"
      fill_in "Description", with: "Vacation!"

      click_button "Book It!"

      expect(page).to have_content "Your room has been booked!"
    end
  end

  # context "an existing booking" do
  #   scenario "should see an error message that room is already booked" do

  #   end
  # end
end
