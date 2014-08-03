class CreateSymptoms < ActiveRecord::Migration
  def change
    create_table :symptoms do |t|
      t.references :user, index: true

      t.timestamps
    end
  end
end
