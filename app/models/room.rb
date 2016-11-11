class Room < ActiveRecord::Base
  belongs_to :hotel, counter_cache: true
  belongs_to :room_type
end
