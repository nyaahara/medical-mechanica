class CreateSickComments < ActiveRecord::Migration
  def change
    create_table :sick_comments do |t|
      t.integer :comment_by_user_id
      t.references :sick
      t.references :user
      t.integer :is_owner_comment
      t.string :contents

      t.timestamps
    end

    add_index :sick_comments, [:user_id, :sick_id]
    add_index :sick_comments, [:sick_id, :user_id]
  end
end
