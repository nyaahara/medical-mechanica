class SickComment < ActiveRecord::Base
  belongs_to :comment_by_user, class_name: 'User'
  belongs_to :user
  belongs_to :sick
  before_save :default_values

  def is_owner_comment?
    is_owner_comment == 1
  end

  def created_by?(user)
    return false unless user
    comment_by_user_id == user.id
  end
    

  def default_values
    parent = Sick.find(self.sick_id)
    self.user_id = parent.owner_id ||= 0
    self.is_owner_comment = self.user_id==self.comment_by_user_id ? 1 : 0
  end

end
