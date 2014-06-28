class AddTimeToSymptoms < ActiveRecord::Migration
  def change
    add_column :symptoms, :time, :datetime
  end
end
