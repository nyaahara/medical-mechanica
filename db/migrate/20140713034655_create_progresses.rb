class CreateProgresses < ActiveRecord::Migration
  def change
    create_table :progresses do |t|
      t.references :user, index: true, null: false
      t.references :sick, index: true, null: false
      t.datetime :progress_at

      t.timestamps
    end

    add_index :progresses, [:user_id, :sick_id], unique: false
    add_index :progresses, [:sick_id, :user_id], unique: false
  end
end
