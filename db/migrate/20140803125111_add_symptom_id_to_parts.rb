class AddSymptomIdToParts < ActiveRecord::Migration
  def change
    add_reference :parts, :symptom, index: true
  end
end
