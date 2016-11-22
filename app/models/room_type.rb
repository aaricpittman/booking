class RoomType < ActiveRecord::Base
  has_many :rooms
  has_many :ammenities

  monetize :rate_cents

  def to_label
    name
  end
end
