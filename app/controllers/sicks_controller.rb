class SicksController < ApplicationController
  
  def show
    @sick = Sick.find(params[:id])
    @progresses = @sick.progresses.page params[:page]
    render :show
  end

  def update
    @sick = Sick.find(params[:id])
    @sick[:status] = 1
    @sick[:recover_completely_comment] = sick_params[:recover_completely_comment]
    @sick.save!
    self.show
  end

  def sick_params
    params.require(:sick).permit(:recover_completely_comment)
  end

end
