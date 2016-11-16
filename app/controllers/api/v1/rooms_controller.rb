class Api::V1::RoomsController < ApplicationController
  def available_types
    @hotel = Hotel.find(params[:hotel_id])
    types = @hotel.room_types
      .group(:id, :name, :rate_cents)
      .count
      .map{ |data,count| { id: data[0], name: data[1], rate_cents: data[2], count: count } }

    render json: { types: types }
  end
end
