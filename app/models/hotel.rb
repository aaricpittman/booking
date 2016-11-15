class Hotel < ActiveRecord::Base
  has_many :rooms
  has_many :room_types, through: :rooms

  def to_label
    name
  end
end
