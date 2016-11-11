class Booking < ActiveRecord::Base
  belongs_to :room
  belongs_to :user

  delegate :hotel, to: :room

  def hotel_name
    hotel.name
  end
end
