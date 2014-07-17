class AddLabelToSick < ActiveRecord::Migration
  def change
    add_column :sicks, :label, :string
  end
end
