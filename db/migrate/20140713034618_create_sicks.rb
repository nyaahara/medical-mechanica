class CreateSicks < ActiveRecord::Migration
  def change
    create_table :sicks do |t|
      t.integer :owner_id
      t.integer :status, null:false

      t.timestamps
    end

    add_index :sicks, :owner_id

  end
end
