class Api::V1::RoomsController < ApplicationController
  def index
    @hotel = Hotel.find(params[:hotel_id])

    render json: { rooms: @hotel.rooms.includes(:room_type) }, include: [:room_type]
  end
end
