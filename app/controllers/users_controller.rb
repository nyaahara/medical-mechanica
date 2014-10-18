class UsersController < ApplicationController
  before_action :authenticate, except: :show
  before_action :user_self?, except: :show

  def show
    @user = User.where(id_alias: params[:id]).limit(1)[0]
    @symptoms = Symptom.where(:user_id => @user.id).reverse_order
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
    not_found unless current_user.id_alias.to_s == params[:id]
  end

end
