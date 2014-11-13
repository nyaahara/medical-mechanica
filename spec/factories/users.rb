# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, aliases: [:owner] do
    provider 'twitter'
    sequence(:uid) { |i| "uid#{i}" }
    sequence(:nickname) { |i| "nickname#{i}" }
    sequence(:image_url) { |i| "http://example.com/image#{i}.jpg" }
  end

  ## class: Userを入れないとインスタンスメソッドのテストが出来ないようです。
  factory :twitter_user, class: User do
    sequence(:nickname) { |i| "nickname#{i}" }
    sequence(:image_url) { |i| "http://example.com/image#{i}.jpg" }
    after(:create) do|user|
      FactoryGirl.create(:twitter_auth, user: user)
    end
  end

  factory :facebook_user, class: User do
    sequence(:nickname) { |i| "nickname#{i}" }
    sequence(:image_url) { |i| "http://example.com/image#{i}.jpg" }
    after(:create) do|user|
      FactoryGirl.create(:facebook_auth, user: user)
    end
  end
end
