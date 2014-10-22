class RemoveProviderFromUsers < ActiveRecord::Migration
  def change
    remove_index :users, [:provider, :uid]
    remove_column :users, :provider, :string
  end
end
