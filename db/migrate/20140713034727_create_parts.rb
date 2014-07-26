class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.references :user, index: true, null:false
      t.references :sick, index: true, null:false
      t.references :progress, index: true, null:false
      t.string :memo
      t.integer :x, null:false
      t.integer :y, null:false

      t.timestamps
    end

    add_index :parts, [:user_id, :sick_id, :progress_id], unique: false
  end
end
