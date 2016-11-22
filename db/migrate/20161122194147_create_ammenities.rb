class CreateAmmenities < ActiveRecord::Migration
  def change
    create_table :ammenities do |t|
      t.string :title
      t.integer :room_type_id
      t.string :description

      t.timestamps null: false
    end
  end
end
