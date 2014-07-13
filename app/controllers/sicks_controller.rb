class SicksController < ApplicationController
  
  def show
    @sick = Sick.find(params[:id])
    @progresses = @sick.progresses.page params[:page]
    render :show
  end

  def update
    @sick = Sick.find(params[:id])
    @sick[:status] = 1
    @sick.save!
    self.show
  end

end
