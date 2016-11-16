class RoomType < ActiveRecord::Base
  has_many :rooms

  monetize :rate_cents

  def to_label
    name
  end
end
