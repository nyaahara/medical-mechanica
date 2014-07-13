class AddRecoverCompletelyCommentToSick < ActiveRecord::Migration
  def change
    add_column :sicks, :recover_completely_comment, :string
  end
end
