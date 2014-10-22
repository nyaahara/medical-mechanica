class RemoveUidFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :uid, :string
  end
end
