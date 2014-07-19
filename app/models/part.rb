class Part < ActiveRecord::Base
  belongs_to :user
  belongs_to :sick
  belongs_to :progress


  PARTS = %w(head body arm hand leg foot a b c d e f g h i j k l m n o p q r s t u v w x y z aa bb cc dd ee ff gg hh ii jj kk ll mm nn oo pp qq rr ss tt uu vv ww xx yy zz)
  KINDS = %w(pain itch nausea sting)
  enum part: PARTS
  enum kind: KINDS

  validates :part, presence: true , inclusion: { in: PARTS }
  validates :kind, presence: true , inclusion: { in: KINDS }
  validates :level, presence: true, inclusion: { in: 1..5 }

  before_save :set_key

  private

  def set_key

  end

end
