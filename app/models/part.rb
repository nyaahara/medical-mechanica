class Part < ActiveRecord::Base
  belongs_to :user
  belongs_to :sick
  belongs_to :progress
  
  FRONT_OR_BACK = %w(front back)
  enum front_or_back: FRONT_OR_BACK

  validates :front_or_back, presence: true, inclusion: { in:FRONT_OR_BACK }

end
