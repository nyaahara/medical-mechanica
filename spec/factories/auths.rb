# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :twitter_auth, class: Auth do
    user
    provider 'twitter'
    sequence(:uid) { |i| "uid#{i}" }
  end

  factory :facebook_auth, class: Auth do
    user
    provider 'facebook'
    sequence(:uid) { |i| "uid#{i}" }
  end
end
