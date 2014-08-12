class SymptomsController < ApplicationController

  before_action :authenticate, except: :index

  def new 
    @symptom = current_user.symptom.build
  end 

  def create
    @symptom = current_user.symptom.build(strong_params)
    if @symptom.save
      redirect_to action: 'index', notice: '登録しました'
    else
      render :new
    end
  end

  def index
    @owner = User.find(params[:user_id])
    @symptoms = Symptom.where(:user_id => params[:user_id])
  end

  def edit
    @symptom = Symptom.find(params[:id])
  end

  def update
    @symptom = Symptom.find(params[:id])
    # 保存されたpartsを一旦削除する
    @symptom.parts.each do |p|
      p.destroy!
    end
    if @symptom.update(strong_params)
      redirect_to action: 'index', notice: '更新しました'
    else
      render :edit
    end
  end

  def destroy
    @symptom = Symptom.find(params[:id])
    if @symptom.destroy!
      redirect_to action: 'index', notice: '削除しました'
    end
  end


  private

  def strong_params
    
    # 何も入力していない場合にエラーが出るため、strong_parameterしない。
    return unless params.include?('symptom')

    permited = params.require(:symptom).permit(:parts_attributes => [:memo, :front_or_back, :x, :y, :_destroy])
    permited[:parts_attributes].each do | part |
      part[1][:user_id] = current_user.id
    end
    permited
  end

end
