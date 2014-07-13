class ProgressesController < ApplicationController

  before_action :authenticate

  def new
    now = Time.zone.now
    @progress = current_user.progresses.build
    @progress.progress_at = now - now.sec
  end

  def create
    
    sick = Sick.find_or_create_by(:owner_id => current_user.id, :status => 0)
    # sick.save!

    @progress = sick.progresses.build(progress_params) do |p|
      p.user_id = current_user.id
      p.parts.each do |part|
        part.user_id = current_user.id
        part.sick_id = sick.id
      end
    end

    if @progress.save
      redirect_to @progress, notice: '登録しました'
    else
      render :new
    end
  end

  def show
    @progress = Progress.find(params[:id])
  end

  private

  def progress_params
    params.require(:progress).permit(:progress_at, :parts_attributes => [:part, :kind, :level, :x, :y, :_destroy])
  end

end
