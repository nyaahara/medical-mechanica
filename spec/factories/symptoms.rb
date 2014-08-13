# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :symptom do
    user
    parts { Array.new(3) { FactoryGirl.build(:part) } }
    factory :invalid_symptom do
      user nil 
    end
  end

end
