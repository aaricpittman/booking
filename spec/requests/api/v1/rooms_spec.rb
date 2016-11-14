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
