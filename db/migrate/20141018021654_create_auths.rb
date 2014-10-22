class CreateAuths < ActiveRecord::Migration
  def change
    create_table :auths do |t|
      t.string :provider, null:false
      t.string :uid, null:false
      t.timestamps
    end

    add_index :auths, [:provider, :uid], unique: true
  end
end
