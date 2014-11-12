class User < ActiveRecord::Base

  has_many :symptom
  has_many :auth

  validates :nickname, length: { maximum: 50 }
  validates :image_url, length: { maximum: 255 }

  def self.create_from_facebook_auth_hash(auth_hash)
    name = auth_hash[:info][:name]
    image_url = auth_hash[:info][:image]
    User.create do|user|
      user.nickname = name
      user.image_url = image_url
    end
  end

  def self.create_from_twitter_auth_hash(auth_hash)
    nickname = auth_hash[:info][:nickname]
    image_url = auth_hash[:info][:image]
    User.create do|user|
      user.nickname = nickname
      user.image_url = image_url
    end
  end

  def has_twitter?
    auth.find_by_user_id(id).provider == 'twitter'
  end

  def has_facebook?
    auth.find_by_user_id(id).provider == 'facebook'
  end

  def facebook_url
    'https://facebook.com/' + auth.find_by_user_id(id).uid
  end
end
