class SymptomsController < ApplicationController
  before_action :authenticate

  def new
    @symptom = current_user.created_symptoms.build
  end

  def create
    @symptom = current_user.created_symptoms.numbering_and_build(current_user)
    if @symptom.save
      redirect_to @symptom, notice: '登録しました'
    else
      render :new
    end
  end

end
