ActiveAdmin.register RoomType do
  permit_params :name, :rate

  filter :name

  index do
    selectable_column
    column :name
    column :rate
    actions
  end

end
