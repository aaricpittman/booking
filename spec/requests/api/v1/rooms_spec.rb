require "rails_helper"

RSpec.describe "GET /api/v1/hotels/:hotel_id/rooms/available_types", type: :request do
  let(:hotel) { create(:hotel) }
  let(:queen_type) { create(:room_type, name: "Queen", rate_cents: 7999) }
  let(:king_type) { create(:room_type, name: "King", rate_cents: 9999) }

  it 'returns a list of room types and counts of each' do
    create_list(:room, 2, hotel: hotel, room_type: queen_type)
    create_list(:room, 3, hotel: hotel, room_type: king_type)

    get "/api/v1/hotels/#{hotel.id}/rooms/available_types"

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
        "count" => 3
      }
    ])
  end
end
