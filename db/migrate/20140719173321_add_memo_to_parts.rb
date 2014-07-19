class AddMemoToParts < ActiveRecord::Migration
  def change
    add_column :parts, :memo, :string
  end
end
