class WelcomeController < ApplicationController
  def index
    @symptoms = Symptom.where(1).order(:created_at)
  end
end
