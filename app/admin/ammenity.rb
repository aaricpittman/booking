ActiveAdmin.register Ammenity do
  permit_params :room_type_id, :title, :description

  filter :room_type
  filter :title

  index do
    selectable_column
    column :room_type
    column :title
    column :description
    actions
  end

end
