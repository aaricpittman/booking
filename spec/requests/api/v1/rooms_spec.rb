require "rails_helper"

RSpec.describe "GET /api/v1/hotels/:hotel_id/rooms", type: :request do
  let(:hotel) { create(:hotel) }

  it "returns a list of all rooms" do
    queen_room = create(:room,
      hotel: hotel,
      room_type: create(:room_type, name: "Queen")
    )
    king_room = create(
      :room,
      hotel: hotel,
      room_type: create(:room_type, name: "King")
    )

    get "/api/v1/hotels/#{hotel.id}/rooms"

    expect(json_body["rooms"].count).to eq(2)
  end
end

RSpec.describe "GET /api/v1/hotels/:hotel_id/rooms/types_count", type: :request do
  let(:hotel) { create(:hotel) }
  let(:queen_type) { create(:room_type, name: "Queen") }
  let(:king_type) { create(:room_type, name: "King") }

  it 'returns a list of room types and counts of each' do
    create_list(:room, 2, hotel: hotel, room_type: queen_type)
    create_list(:room, 3, hotel: hotel, room_type: king_type)

    get "/api/v1/hotels/#{hotel.id}/rooms/types_count"

    expect(json_body['types']).to match_array([
      {
        "id" => queen_type.id,
        "name" => "Queen",
        "count" => 2
      },
      {
        "id" => king_type.id,
        "name" => "King",
        "count" => 3
      }
    ])
  end
end
