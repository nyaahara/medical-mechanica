class WelcomeController < ApplicationController
  def index
                                                      # TODO desc
    @progresses = Progress.joins(:sick,:parts,:user).order(:created_at).take(50)
    @users = User.where(1).order(:created_at)
  end
end
