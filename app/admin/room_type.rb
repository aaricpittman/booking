ActiveAdmin.register RoomType do
  permit_params :name, :rate

  filter :name

  index do
    selectable_column
    column :name
    column :rate
    actions
  end

  form do |f|
    inputs do
      input :name
      input :rate_cents, label: 'Rate in Cents'
    end

    actions
  end

end
