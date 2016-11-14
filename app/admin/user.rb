ActiveAdmin.register User do
  permit_params :email, :password

  index do
    selectable_column
    column :email
    actions
  end

end
