class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.integer :room_id
      t.date :check_in
      t.date :check_out
      t.text :description

      t.timestamps null: false
    end

    add_index :bookings, [:user_id]
    add_index :bookings, [:room_id]
  end
end
