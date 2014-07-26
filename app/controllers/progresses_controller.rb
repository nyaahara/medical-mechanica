class ProgressesController < ApplicationController

  before_action :authenticate

  def create
    
    # 親のsickがなければ、新しく作ります。
    @sick = Sick.find_or_create_by(:owner_id => current_user.id, :status => 0)
    @sick.save!

    # Strong parameterとキーの設定を行います。
    permited_params = progress_params(@sick)
    
    @progress = @sick.progresses.build(permited_params)

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

    # 親のsickと一緒にprogressを取得します
    @progress = Progress.includes(:sick).find(params[:id])

    # 保存されたpartsを一旦削除する
    @progress.parts.each do |p|
      p.destroy!
    end

    # Strong parameterとキーの設定を行います。
    permited_params = progress_params(@progress.sick)

    # データを更新します。
    if @progress.update(permited_params)
      redirect_to @progress.sick, notice:'編集しました'
    else
      render :new
    end
  end

  private

  def progress_params(sick)
    permited = params.require(:progress).permit(:progress_at, :parts_attributes => [:memo, :x, :y, :_destroy])
    permited[:user_id] = sick.owner_id
    permited[:parts_attributes].each do |part|
      part[1][:user_id] = sick.owner_id
      part[1][:sick_id] = sick.id
    end
    permited
  end

end
