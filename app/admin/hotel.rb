ActiveAdmin.register Hotel do
  permit_params :name

  filter :name

  index do
    selectable_column
    column :name
    column "Rooms" do |hotel|
      link_to "View (#{hotel.rooms_count})", admin_hotel_rooms_path(hotel)
    end
    actions
  end
end
