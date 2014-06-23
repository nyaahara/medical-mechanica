class Symptom < ActiveRecord::Base
  # primary_keysを指定しないと下位モデルの更新がうまくいかない。
  self.primary_keys = :owner_id, :symptom_id
  has_many :symptom_details, class_name:'SymptomDetail', foreign_key: [:owner_id, :symptom_id], dependent: :destroy
  accepts_nested_attributes_for :symptom_details, allow_destroy: true
  belongs_to :owner, class_name: 'User'

  validate :elapsed?, on: :create
  
  def self.numbering(user)
    before = Symptom.where(:owner_id => user.id).reorder(:created_at)

    # TODO 条件代入
    if before.present?
      before.last[:symptom_id] + 1
    else
      1
    end
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
