class Room < ActiveRecord::Base
  belongs_to :hotel, counter_cache: true
  belongs_to :room_type
  has_many :bookings

  def self.by_type(room_type_id)
    where(room_type_id: room_type_id)
  end

  def self.available_on(start_date, end_date)
    joins("LEFT OUTER JOIN bookings ON (bookings.room_id = rooms.id)")
      .where("(?, ?) OVERLAPS (bookings.check_out, bookings.check_in) = 'f' OR bookings.id IS NULL",
        start_date.beginning_of_day,
        end_date.beginning_of_day
      )
  end
end
