ActiveAdmin.register RoomType do
  permit_params :name, :rate

  [:name, :rate].each do |attribute|
    filter attribute
  end

  index do
    selectable_column
    column :name
    column :rate
    actions
  end
end
