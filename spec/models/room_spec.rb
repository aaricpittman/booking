require 'rails_helper'

RSpec.describe Room, '.available_on', type: :model do
  it "should return a list of rooms that are not booked on during that date range" do
    start_date = Time.now
    end_date = 3.days.from_now

    room1 = create(:room)

    room2 = create(:room)
    booking = create(:booking,
      room: room2,
      check_in: start_date + 1.day,
      check_out: end_date)

    room3 = create(:room)
    booking = create(:booking,
      room: room3,
      check_in: start_date - 2.day,
      check_out: start_date)

    room4 = create(:room)
    booking = create(:booking,
      room: room4,
      check_in: end_date,
      check_out: end_date + 2.days)

    room5 = create(:room)
    booking = create(:booking,
      room: room5,
      check_in: 1.year.ago,
      check_out: 1.year.ago + 2.days)

    puts Booking.all.inspect

    expect(Room.available_on(start_date, end_date)).to match_array([
      room1,
      room3,
      room4,
      room5
    ])
  end
end
