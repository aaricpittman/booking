class Api::V1::RoomsController < ApplicationController
  before_action :get_hotel

  def index
    render json: { rooms: @hotel.rooms.includes(:room_type) }, include: [:room_type]
  end

  def types_count
    types = @hotel.room_types
      .group(:id, :name)
      .count
      .map{ |data,count| { id: data[0], name: data[1], count: count } }

    render json: { types: types }
  end

  private

  def get_hotel
    @hotel = Hotel.find(params[:hotel_id])
  end
end
