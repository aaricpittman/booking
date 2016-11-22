FactoryGirl.define do
  factory :ammenity do
    title "MyString"
    room_type_id 1
    description "MyString"
  end
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
    total_cents 10000
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
    rate_cents 9999
  end

  factory :user do
    email { Faker::Internet.email }
    password "abc123"
    password_confirmation "abc123"
  end
end
