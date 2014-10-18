class User < ActiveRecord::Base

  has_many :symptom

  validates :provider, presence: true
  validates :uid, presence: true
  validates :nickname, length: { maximum: 50 }
  validates :image_url, length: { maximum: 255 }
  validates :id_alias, presence:true, length:{ maximum: 50 }

  def self.find_or_create_from_auth_hash(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    nickname = auth_hash[:info][:nickname]
    image_url = auth_hash[:info][:image]
    id_alias = auth_hash[:info][:nickname]

    User.find_or_create_by(provider: provider, uid: uid) do |user|
      user.nickname = nickname
      user.image_url = image_url
      user.id_alias = id_alias
    end
  end
end
