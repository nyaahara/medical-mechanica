class UsersController < ApplicationController
  before_action :authenticate

  def show
    p "usouso"
    owner_id = params[:id]
    @user = User.find(owner_id)
    @symptoms = Symptom.where(:owner_id => owner_id).find_each
  end

end
