class Symptom < ActiveRecord::Base

  mount_uploader :symptom_image, SymptomImageUploader

  # primary_keysを指定しないと下位モデルの更新がうまくいかない。
  self.primary_keys = :owner_id, :symptom_id
  has_many :details, class_name:'SymptomDetail', foreign_key: [:owner_id, :symptom_id], dependent: :destroy
  accepts_nested_attributes_for :details, allow_destroy: true
  belongs_to :owner, class_name: 'User'

  validates_presence_of :details
  validates_presence_of :time_symptoms, presence: true

  validate :elapsed?, on: :create
  validate do |model|
    self.past?(time_symptoms)
  end
  
  def self.numbering(user)
    before = Symptom.where(:owner_id => user.id).reorder(:created_at)

    # TODO 条件代入
    if before.present?
      before.last[:symptom_id] + 1
    else
      1
    end
  end

  def past?(time)
    errors.add(:time_symptoms,"未来の日付は登録できません。") if Time.zone.now <= time
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
