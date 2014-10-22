class Auth < ActiveRecord::Base

  belongs_to :user

  validates :provider, presence: true
  validates :uid, presence: true

  def self.create_from_auth_hash(auth_hash, user)

    provider = auth_hash[:provider]
    uid = auth_hash[:uid]

    Auth.create do|auth|
      auth.provider = provider
      auth.uid = uid
      auth.user_id = user.id
    end

  end

end
