class Sick < ActiveRecord::Base
  has_many :progresses, dependent: :destroy
  has_many :parts, dependent: :destroy
  has_many :sick_comments, dependent: :destroy
  belongs_to :owner, class_name: 'User'

  before_save :default_values

  def default_values
    self.status ||= 0
  end

  def created_by?(user)
    return false unless user
    owner_id == user.id
  end

  #recover completely
  def still_sick?
    status == 0 # TODO enumにする
  end

  def recover_completely?
    status == 1
  end

end
