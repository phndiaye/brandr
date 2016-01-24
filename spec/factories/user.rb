FactoryGirl.define do
  factory :user do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    username { Faker::Internet.user_name("#{firstname} #{lastname}") }
    email { Faker::Internet.email }
    password 'password123'
    password_confirmation 'password123'
  end
end
