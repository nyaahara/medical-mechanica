# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :part do
    user nil
    sick nil
    progress nil
    part ""
    kind ""
    level ""
    x ""
    y ""
  end
end
