class CreateSymptoms < ActiveRecord::Migration
  def change
    create_table :symptoms do |t|
      t.integer :owner_id
      t.integer :symptom_id, null:false
      t.timestamps
    end

    add_index :symptoms, [:symptom_id], unique: true
  end
end
