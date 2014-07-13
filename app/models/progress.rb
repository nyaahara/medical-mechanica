class Progress < ActiveRecord::Base
  has_many :parts
  accepts_nested_attributes_for :parts, allow_destroy: true
  belongs_to :user
  belongs_to :sick

  paginates_per 1

end
