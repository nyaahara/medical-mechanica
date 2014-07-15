class User < ActiveRecord::Base

  has_many :has_sick, class_name: 'Sick', foreign_key: :owner_id
  has_many :sick_comments, class_name: 'SickComment', foreign_key: :comment_by_user_id
  has_many :sick_comments
  has_many :progresses
  has_many :parts

  validates :provider, presence: true
  validates :uid, presence: true
  validates :nickname, length: { maximum: 50 }
  validates :image_url, length: { maximum: 255 }
 # validates :sex, inclusion: { in: 0..1 }, presence: false
  
  has_many :created_symptoms, class_name: 'Symptom', foreign_key: :owner_id, dependent: :destroy
  
  def self.find_or_create_from_auth_hash(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    nickname = auth_hash[:info][:nickname]
    image_url = auth_hash[:info][:image]

    User.find_or_create_by(provider: provider, uid: uid) do |user|
      user.nickname = nickname
      user.image_url = image_url
    end
  end
end
