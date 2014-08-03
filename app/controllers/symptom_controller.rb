class SymptomController < ApplicationController
  
  def new
    @symptom = current_user.symptom.build
  end

end
