class AddDefaultToHotelRoomCount < ActiveRecord::Migration
  def change
    change_column :hotels, :rooms_count, :integer, default: 0
  end
end
