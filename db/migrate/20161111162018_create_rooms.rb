class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :hotel_id
      t.integer :room_type_id

      t.timestamps null: false
    end

    add_index :rooms, [:hotel_id]
  end
end
