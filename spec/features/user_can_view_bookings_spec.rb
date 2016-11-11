require 'rails_helper'

RSpec.feature "user can view bookings", type: :feature do
  let(:user) { create(:user, password: "abc123") }
  let(:hotel) { create(:hotel, name: 'Four Seasons') }
  let(:room_type) { create(:room_type) }
  let(:room) { create(:room, hotel: hotel, room_type: room_type) }

  scenario "should see calendar with existing bookings" do
    check_in = Time.now.to_date
    check_out = 1.day.from_now.to_date
    booking = create(:booking,
      user: user,
      room: room,
      check_in: Time.now,
      check_out: 1.day.from_now
    )

    sign_in_with(user.email, "abc123")

    visit root_path

    within ".simple-calendar" do
      (check_in...check_out).each do |day|
        expect(page).to have_css "[data-date='#{day}']", text: "Four Seasons"
      end
    end
  end

  scenario "should see list of existing bookings" do
    check_in = Time.now.to_date
    check_out = 1.day.from_now.to_date
    booking = create(:booking,
      user: user,
      room: room,
      check_in: Time.now,
      check_out: 1.day.from_now
    )

    sign_in_with(user.email, "abc123")

    visit root_path

    within ".bookings-list" do
      expect(page).to have_css "[data-booking-id='#{booking.id}']", text: "Four Seasons"
    end
  end
end
