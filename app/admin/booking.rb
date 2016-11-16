ActiveAdmin.register Booking do
  permit_params :user_id, :room_id, :check_in, :check_out, :description

  filter :user
  filter :check_in
  filter :check_out

  index do
    selectable_column
    column :user
    column :hotel
    column :check_in
    column :check_out
    column :total
    column :charge_id
    actions
  end

end
