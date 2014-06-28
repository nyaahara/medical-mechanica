class SymptomsController < ApplicationController
  before_action :authenticate

  def new
    @symptom = current_user.created_symptoms.build
  end

  def create
    p = symptom_params
    # TODO current_userのidを代入しなきゃいけないのは、芋っぽいのでなんとかしたい。
    p[:owner_id] = current_user.id
    # TODO numberingの引数にcurrent_userって芋っぽすぎるのでなんとかしたい。
    p[:symptom_id] = current_user.created_symptoms.numbering(current_user)
    @symptom = Symptom.new(p)

    if @symptom.save
      redirect_to @symptom, notice: '登録しました'
    else
      render :new
    end
  end

  def show
    owner_id, symptom_id = params[:id].split(/,/)
    @symptom = Symptom.find([owner_id,symptom_id])
  end

  private

  def symptom_params
    params.require(:symptom).permit(:details_attributes => [:part, :kind, :level, :_destroy])
  end

end
