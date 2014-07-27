class AddFrontOrBackToPart < ActiveRecord::Migration
  def change
    add_column :parts, :front_or_back, :integer
  end
end
