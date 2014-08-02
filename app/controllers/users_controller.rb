class UsersController < ApplicationController
  before_action :authenticate

  def show
    owner_id = params[:id]
    @user = User.find(owner_id)
    @sicks = Sick.where(:owner_id => owner_id).find_each
  end

  def edit
    owner_id = params[:id]
    @user = User.find(owner_id)
  end

  def update
    @user = current_user    
    if @user.update(user_params)
      redirect_to @user, notice: '更新しました'
    else
      render :edit
    end
  end

  def destroy
    @user = current_user
    @user.destroy!
    reset_session
    redirect_to root_path, notice: '退会しました'
  end
  
  private 

  def user_params
    params.require(:user).permit(:birth,:sex)
  end

end
