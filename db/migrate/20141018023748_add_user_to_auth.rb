class AddUserToAuth < ActiveRecord::Migration
  def change
    add_reference :auths, :user, index: true
  end
end
