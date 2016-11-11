ActiveAdmin.register Room do
  permit_params :room_type_id

  belongs_to :hotel

  filter :room_type

  index do
    selectable_column
    column "Type" do |room|
      "#{room.room_type.name} (#{room.room_type.rate})"
    end
    actions
  end
end
