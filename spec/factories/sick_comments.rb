# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sick_comment do
    comment_by_user_id 1
    sick ""
    user ""
    is_owner_comment 1
    contents "MyString"
  end
end
