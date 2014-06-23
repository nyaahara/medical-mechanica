class SymptomDetail < ActiveRecord::Base
  validates :part, presence: true, inclusion: { in: 0..50 }
  validates :kind, presence: true, inclusion: { in: 0..3 }
  validates :level, presence: true, inclusion: { in: 1..5 }

  belongs_to :owner, class_name: 'User'
  belongs_to :symptom, class_name: 'Symptom', foreign_key: [:owner_id, :symptom_id]
end
