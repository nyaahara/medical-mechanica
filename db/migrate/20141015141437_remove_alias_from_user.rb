class RemoveAliasFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :alias
  end
end
