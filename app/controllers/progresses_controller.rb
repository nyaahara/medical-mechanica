class ProgressesController < ApplicationController

  before_action :authenticate

  def create
    
    @sick = Sick.find_or_create_by(:owner_id => current_user.id, :status => 0)
    permited_params = sssss(progress_params,@sick)
    # permited_params = progress_params
    # @sick = if permited_params[:sick_id].present?
    #   Sick.find(permited_params[:sick_id])
    # else
    #   Sick.create(:owner_id => current_user.id)
    # end
    
    @sick.label = params[:sick][:label]
    @sick.save!

    @progress = @sick.progresses.build(permited_params)
    # @progress = @sick.progresses.build(permited_params) do |p|
    #   p.user_id = current_user.id
    #   p.parts.each do |part|
    #     part.user_id = current_user.id
    #     part.sick_id = @sick.id
    #   end
    # end

    if @progress.save
      redirect_to @sick, notice: '登録しました'
    else
      render :new
    end
  end

  def show
    @progress = Progress.find(params[:id])
  end

  def edit
    @progress = Progress.find(params[:id])
  end

  def update

    # TODO sickだけ検索して、関連を引きづり出す方法があるはずだよ？
    @progress = Progress.find(params[:id])
    @sick = Sick.find(@progress.sick_id)

    # 保存されたpartsを一旦削除する
    @progress.parts.each do |p|
      p.destroy!
    end

    permited_params = sssss(progress_params,@sick)

    if @progress.update(permited_params)
      redirect_to @sick, notice:'編集しました'
    else
      render :new
    end
  end

  private

  def sssss(data,sick)
    data[:user_id] = sick.owner_id
    data[:parts_attributes].each do |pp|
      pp[1][:user_id] = sick.owner_id
      pp[1][:sick_id] = sick.id
    end
    data
  end

  def progress_params
    params.require(:progress).permit(:sick_id, :progress_at, :parts_attributes => [:part, :kind, :level, :x, :y, :_destroy])
  end

end
