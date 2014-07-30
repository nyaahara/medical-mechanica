class SicksController < ApplicationController


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

  def destroy
    @sick = Sick.find(params[:id])
    @sick.destroy!
    redirect_to root_path, notice: '削除しました'
  end

end
