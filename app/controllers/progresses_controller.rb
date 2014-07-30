class ProgressesController < ApplicationController

  before_action :authenticate

  def new
    now = Time.zone.now
    @progress = current_user.progresses.build
    @progress.progress_at = now - now.sec
    @still_sicks = Sick.where(:owner_id => current_user.id, :status => 0)
  end

  def create
    
    # 親のsickがなければ、新しく作ります。
    @sick = Sick.find_or_create_by(:owner_id => current_user.id, :status => 0)
    @sick.save!

    # Strong parameterとキーの設定を行います。
    permited_params = progress_params(@sick)
    
    @progress = @sick.progresses.build(permited_params)

    if @progress.save
      redirect_to @progress, notice: '登録しました'
    else
      render :new
    end
  end

  def show
    tmp_progress = Progress.find(params[:id])
    @sick = Sick.find(tmp_progress.sick_id)
    # TODO 選択したprogress_idのページを初期表示したい
    @progresses = @sick.progresses.page params[:page]
    @comments = @sick.sick_comments.includes(:comment_by_user).order(:created_at)
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

  def destroy
    @progress = Progress.find(params[:id])
    @sick = @progress.sick
    @progress.destroy!

    if @sick.progresses.length == 0
      @sick.destroy!
      redirect_to root_path, notice: '削除しました'
    else
      redirect_to @sick.progresses.first, notice: '削除しました'
    end
  end

  private

  def progress_params(sick)
    permited = params.require(:progress).permit(:progress_at, :parts_attributes => [:memo, :front_or_back, :x, :y, :_destroy])
    permited[:user_id] = sick.owner_id
    permited[:parts_attributes].each do |part|
      part[1][:user_id] = sick.owner_id
      part[1][:sick_id] = sick.id
    end
    permited
  end

end
