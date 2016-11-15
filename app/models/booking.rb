class Booking < ActiveRecord::Base
  belongs_to :room
  belongs_to :user

  validates :check_in, :check_out, :room_id, :user_id, presence: true

  delegate :hotel, to: :room

  def hotel_name
    hotel.name
  end
end
