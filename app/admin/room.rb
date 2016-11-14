ActiveAdmin.register Room do
  belongs_to :hotel

  filter :room_type

  index do
    selectable_column
    column :room_type do |room|
      room.room_type.name
    end
    actions
  end
end
