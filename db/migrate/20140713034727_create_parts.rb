class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.references :user, index: true, null:false
      t.references :sick, index: true, null:false
      t.references :progress, index: true, null:false
      t.integer :part, null:false
      t.integer :kind, null:false
      t.integer :level, null:false
      t.integer :x, null:false
      t.integer :y, null:false

      t.timestamps
    end

    add_index :parts, [:user_id, :sick_id, :progress_id], unique: false
    add_index :parts, [:user_id, :sick_id, :part], unique: false
    add_index :parts, [:user_id, :sick_id, :kind], unique: false
    add_index :parts, [:part], unique: false
    add_index :parts, [:kind], unique: false
  end
end
