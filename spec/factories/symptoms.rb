# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :symptom do
    owner
    sequence(:symptom_id) { |i| "{i}" }
  end
end
