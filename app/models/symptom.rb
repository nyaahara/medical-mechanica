class Symptom < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :symptom_details, class_name:'SymptomDetail', foreign_key: :symptom_id, dependent: :destroy

  validate :elapsed?, on: :create
  
  def self.numbering_and_build(user)
    before = Symptom.where(:owner_id => user.id).order(:created_at).reverse_order

    # TODO 条件代入
    if before.present?
      symptom_id = before.last[:symptom_id] + 1
    else
      symptom_id = 1
    end
    Symptom.create(:owner_id => user.id, :symptom_id => symptom_id)
  end

  private
  
  def elapsed?
    before = Symptom.where(:owner_id => owner_id).order(:created_at).reverse_order
    return unless before.present?

    if Time.zone.now < before.last[:created_at] + 60 * 60 * 1
      errors.add(:created_at, ' 前回の登録から１時間経過していません。')
    end
  end

end
