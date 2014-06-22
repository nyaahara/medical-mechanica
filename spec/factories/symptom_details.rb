# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :symptom_detail do
    owner
    symptom
    sequence(:symptom_detail_id) { |i| "{i}" }
    part  { rand(1..30) }
    kind  { rand(1..30) }
    level { rand(1..30) }
  end
end
