class CreateSymptomDetails < ActiveRecord::Migration
  def change
    create_table :symptom_details do |t|
      t.integer :owner_id, null:false
      t.integer :symptom_id, null:false
      t.integer :symptom_detail_id, null: false
      t.integer :part, null: false
      t.integer :kind, null: false
      t.integer :level, null: false
      t.timestamps
    end

    add_index :symptom_details, [:part]
  end
end
