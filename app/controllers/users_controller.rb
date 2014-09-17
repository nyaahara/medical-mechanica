class UsersController < ApplicationController
  before_action :authenticate, except: :show
  before_action :user_self?, except: :show

  def show
    @owner = User.find(params[:id])
    @symptoms = Symptom.where(:user_id => params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash.now[:notice] = '更新しました'
    end
    render action: 'edit'
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

  def user_self?
    not_found unless current_user.id.to_s == params[:id]
  end

end
