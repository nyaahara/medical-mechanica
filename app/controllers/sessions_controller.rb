class SessionsController < ApplicationController
  def create
    req = request.env['omniauth.auth']
    user = User.find_or_create_from_auth_hash(req)
    user.update({image_url: req[:info][:image], id_alias: req[:info][:nickname]})
    session[:user_id] = user.id
    redirect_to controller: 'users', action: 'show', id: user.id_alias, notice: 'ログインしました'
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end

end
