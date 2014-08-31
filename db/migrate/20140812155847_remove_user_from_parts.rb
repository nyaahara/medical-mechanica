class RemoveUserFromParts < ActiveRecord::Migration
  def change
    remove_reference :parts, :user, index: true
  end
end
