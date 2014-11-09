class SessionsController < ApplicationController

  def show
    # nothing
  end


  def create
    req = request.env['omniauth.auth']
    auth = Auth.find_by(provider: req[:provider], uid: req[:uid])

    if auth.present?
      user_id = auth.user_id
      user = User.find(user_id)
      user.update({image_url: req[:info][:image]})
    else
      # new user
      case req[:provider]
        when 'twitter'
          user = User.create_from_twitter_auth_hash(req)
        when 'facebook'
          user = User.create_from_facebook_auth_hash(req)
        else
          raise StandardError
      end
      Auth.create_from_auth_hash(req, user)
    end

    session[:user_id] = user.id
    redirect_to controller: 'users', action: 'show', id: user.id, notice: 'ログインしました'
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end

end
