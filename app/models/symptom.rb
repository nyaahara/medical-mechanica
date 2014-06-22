class Symptom < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :symptom_details, class_name:'SymptomDetail', foreign_key: :symptom_id, dependent: :destroy

  validate :elapsed?, on: :create
  
  def self.numbering_and_build
    before = Symptom.where(:owner_id => owner_id).order(:created_at).reverse_order
    symptom_id = unless before.present? ? 1 : before.last[:symptom_id] + 1
    params.require(owner_id, symptom_id)
    Symptom.build(params)
  end

  private
  
  def elapsed?
    before = Symptom.where(:owner_id => owner_id).order(:created_at).reverse_order
    return unless before.present?

    if created_at < before.last[:created_at] + 60 * 60 * 1
      errors.add(:created_at, ' 前回の登録から１時間経過していません。')
    end
  end

end
