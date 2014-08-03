class Symptom < ActiveRecord::Base
  has_many :parts, dependent: :destroy
  accepts_nested_attributes_for :parts, allow_destroy: true
  belongs_to :user

  def created_by?(user)
    return false unless user
    user_id == user.id
  end

end
