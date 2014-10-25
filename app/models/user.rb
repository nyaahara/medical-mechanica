class User < ActiveRecord::Base

  has_many :symptom
  has_many :auth

  validates :nickname, length: { maximum: 50 }
  validates :image_url, length: { maximum: 255 }
  validates :id_alias, presence:true, length:{ maximum: 50 }

  def self.create_from_facebook_auth_hash(auth_hash)
    name = auth_hash[:info][:name]
    image_url = auth_hash[:info][:image]
    id_alias = auth_hash[:provider] + auth_hash[:uid]
    User.create do|user|
      user.nickname = name
      user.image_url = image_url
      user.id_alias = id_alias
    end
  end

  def self.create_from_twitter_auth_hash(auth_hash)
    nickname = auth_hash[:info][:nickname]
    image_url = auth_hash[:info][:image]
    id_alias = auth_hash[:provider] + auth_hash[:uid]
    User.create do|user|
      user.nickname = nickname
      user.image_url = image_url
      user.id_alias = id_alias
    end
  end
end
