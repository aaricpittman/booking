class Api::V1::RoomsController < ApplicationController
  def available_types
    @hotel = Hotel.find(params[:hotel_id])
    check_in = Date.parse(params[:check_in])
    check_out = Date.parse(params[:check_out])

    types = @hotel.rooms
      .joins(:room_type)
      .available_on(check_in, check_out)
      .group("room_types.id", "room_types.name", "room_types.rate_cents")
      .count
      .map{ |data,count| { id: data[0], name: data[1], rate_cents: data[2], count: count } }

    render json: { types: types }
  end
end
