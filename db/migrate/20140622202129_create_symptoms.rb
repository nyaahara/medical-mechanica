class CreateSymptoms < ActiveRecord::Migration
  def change
    create_table :symptoms do |t|
      t.integer :owner_id, null:false
      t.integer :symptom_id, null:false
      t.timestamps
    end
    add_index :symptoms, [:owner_id, :symptom_id], unique: true
  end
end
