# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :part do
    front_or_back "back"
    x 50
    y 50
    sequence(:memo) { |i| "memo#{i}" }
  end
end
