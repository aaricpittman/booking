require "rails_helper"

RSpec.describe "GET /api/v1/hotels/:hotel_id/rooms/available_types", type: :request do
  let(:hotel) { create(:hotel) }
  let(:queen_type) { create(:room_type, name: "Queen", rate_cents: 7999) }
  let(:king_type) { create(:room_type, name: "King", rate_cents: 9999) }
  let(:suite_type) { create(:room_type, name: "Suite", rate_cents: 19999) }
  let(:check_in) { Time.now.to_date }
  let(:check_out) { 3.days.from_now.to_date }

  before(:each) do
    create_list(:room, 2, hotel: hotel, room_type: queen_type)
    kings = create_list(:room, 3, hotel: hotel, room_type: king_type)
    suite = create(:room, hotel: hotel, room_type: suite_type)

    create(:booking,
      room: suite,
      check_in: check_in,
      check_out: check_out
    )

    create(:booking,
      room: kings.first,
      check_in: check_in,
      check_out: check_out
    )
  end

  it 'returns a list of room types, rates, counts of each' do
    get "/api/v1/hotels/#{hotel.id}/rooms/available_types?check_in=#{check_in}&check_out=#{check_out}"

    expect(json_body['types']).to match_array([
      {
        "id" => queen_type.id,
        "name" => "Queen",
        "rate_cents" => 7999,
        "count" => 2
      },
      {
        "id" => king_type.id,
        "name" => "King",
        "rate_cents" => 9999,
        "count" => 2
      }
    ])
  end
end
