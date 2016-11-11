class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name
      t.integer :rooms_count

      t.timestamps null: false
    end
  end
end
