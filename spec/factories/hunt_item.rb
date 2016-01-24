FactoryGirl.define do
  factory :hunt_item do
    top { rand(1..20) }
    left { rand(1..48) }
  end
end
