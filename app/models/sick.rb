class Sick < ActiveRecord::Base
  has_many :progresses
  has_many :parts
  belongs_to :owner, class_name: 'User'

  before_save :default_values

  def default_values
    self.status ||= 0
  end

end
