class SicksController < ApplicationController

  def new
    now = Time.zone.now
    @progress = current_user.progresses.build
    @progress.progress_at = now - now.sec
    @still_sicks = Sick.where(:owner_id => current_user.id, :status => 0)
  end

  def show
    @sick = Sick.find(params[:id])
    @progresses = @sick.progresses.page params[:page]
    @comments = @sick.sick_comments.includes(:comment_by_user).order(:created_at)

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
