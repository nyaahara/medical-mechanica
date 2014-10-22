class SessionsController < ApplicationController
  def create
    req = request.env['omniauth.auth']
    auth = Auth.find_by(provider: req[:provider], uid: req[:uid])

    if auth.present?
      user = User.find(id: auth.user_id)
      user.update({image_url: req[:info][:image], id_alias: req[:info][:nickname]})
    else
      # new user
      user = User.create_from_auth_hash(req)
      Auth.create_from_auth_hash(req, user)
    end

    session[:user_id] = user.id
    redirect_to controller: 'users', action: 'show', id: user.id_alias, notice: 'ログインしました'
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end

end
