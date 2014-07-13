class WelcomeController < ApplicationController
  def index
    @sicks = Sick.where(1).order(:created_at)
  end
end
