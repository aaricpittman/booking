# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin_role = Role.create!(name: 'Super Admin')

admin_user = User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
admin_user.roles << admin_role

user = User.create!(email: 'user@example.com', password: 'password', password_confirmation: 'password')

room_types = [
    RoomType.create(name: 'Double Queen', rate: '9999'),
    RoomType.create(name: 'King', rate: '15999'),
    RoomType.create(name: 'Suite', rate: '19999')
]

['Four Season', 'The Ritz', 'The Plaza'].each do |hotel_name|
  hotel = Hotel.create(name: hotel_name)

  10.times do
    Room.create(hotel: hotel, room_type: room_types.sample)
  end
end
