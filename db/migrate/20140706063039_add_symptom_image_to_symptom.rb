class AddSymptomImageToSymptom < ActiveRecord::Migration
  def change
    add_column :symptoms, :symptom_image, :string
  end
end
