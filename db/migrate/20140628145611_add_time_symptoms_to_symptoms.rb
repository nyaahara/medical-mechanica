class AddTimeSymptomsToSymptoms < ActiveRecord::Migration
  def change
    remove_column :symptoms, :time, :datetime
    add_column :symptoms, :time_symptoms, :datetime
  end
end
