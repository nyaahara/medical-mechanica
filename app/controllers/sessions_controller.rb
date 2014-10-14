class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth_hash(request.env['omniauth.auth'])
    user.update({image_url: request.env['omniauth.auth'][:info][:image]})
    session[:user_id] = user.id
    redirect_to controller: 'users', action: 'show', id: user.id, notice: 'ログインしました'
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end

end
