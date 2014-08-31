class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.references :user, index: true, null:false
      t.references :symptom, index: true, null:false
      t.string :memo
      t.integer :x, null:false
      t.integer :y, null:false
      t.integer :front_or_back, null:false

      t.timestamps
    end
  end
end
