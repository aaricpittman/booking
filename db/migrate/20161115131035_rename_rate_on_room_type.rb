class RenameRateOnRoomType < ActiveRecord::Migration
  def change
    rename_column :room_types, :rate, :rate_cents
  end
end
