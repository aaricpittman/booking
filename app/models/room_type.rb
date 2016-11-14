class RoomType < ActiveRecord::Base
  has_many :rooms

  def to_label
    name
  end
end
