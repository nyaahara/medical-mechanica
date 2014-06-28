class Symptom < ActiveRecord::Base
  # primary_keysを指定しないと下位モデルの更新がうまくいかない。
  self.primary_keys = :owner_id, :symptom_id
  has_many :details, class_name:'SymptomDetail', foreign_key: [:owner_id, :symptom_id], dependent: :destroy
  accepts_nested_attributes_for :details, allow_destroy: true
  belongs_to :owner, class_name: 'User'

  validates_presence_of :details
  validates_presence_of :time_symptoms, presence: true

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
    filler_hour = 1
    filler_sec = filler_hour * 60 * 60

    from = time_symptoms - filler_sec
    to = time_symptoms + filler_sec

    before = Symptom.where(:owner_id => owner_id, :time_symptoms => from..to)
    return unless before.present?
    errors.add(:time_symptoms, "#{filler_hour} 時間以内に他の症状が登録されています。")
  end

end
