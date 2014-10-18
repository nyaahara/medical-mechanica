class AddIdAliasToUser < ActiveRecord::Migration
  def change
    add_column :users, :id_alias, :string
  end
end
