class AddXAndYToSymptomDetail < ActiveRecord::Migration
  def change
    add_column :symptom_details, :x, :string
    add_column :symptom_details, :y, :string
  end
end
