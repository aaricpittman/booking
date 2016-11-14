FactoryGirl.define do
  factory :role_assignment do
    role
    user
  end

  factory :role do
    sequence(:name) { |n| "admin#{n}" }
  end

  factory :booking do
    user
    room
    check_in Time.now
    check_out Time.now + 1.day
    description "MyText"
  end

  factory :hotel do
    name "Four Seasons"
  end

  factory :room do
    hotel
    room_type
  end

  factory :room_type do
    name "Standard Room"
    rate 9999
  end

  factory :user do
    email { Faker::Internet.email }
    password "abc123"
  end
end
