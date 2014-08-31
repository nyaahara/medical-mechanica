class WelcomeController < ApplicationController
  def index
    @users = User.where(1).order(:created_at)
    @symptoms = Symptom.joins(:user).order("created_at DESC").take(50)
  end
end
