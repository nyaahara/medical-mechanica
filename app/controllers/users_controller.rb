class UsersController < ApplicationController
  before_action :authenticate

  def show
    owner_id = params[:id]
    @user = User.find(owner_id)
    @sicks = Sick.where(:owner_id => owner_id).find_each
  end

end
