class WelcomeController < ApplicationController
  def index
                                                      # TODO desc
                                                          # TODO limit 
    @progresses = Progress.includes(:sick).where(1).order(:created_at)
    @users = User.where(1).order(:created_at)
  end
end
