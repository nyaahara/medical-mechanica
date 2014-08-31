class Part < ActiveRecord::Base
  belongs_to :symptom
  
  FRONT_OR_BACK = %w(front back)
  enum front_or_back: FRONT_OR_BACK

  validates :memo, length:{ maximum:1000 }
  validates :x, presence: true, inclusion: { in: 1..310 }
  validates :y, presence: true, inclusion: { in: 1..658 }
  validates :front_or_back, presence: true, inclusion: { in:FRONT_OR_BACK }

end
