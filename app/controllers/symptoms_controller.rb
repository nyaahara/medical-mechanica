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
    @symptom = current_user.symptom.find(params[:id])
  end

  def update
    @symptom = current_user.symptom.find(params[:id])
    # 保存されたpartsを一旦削除する
    @symptom.parts.each {|item| item.destroy!}

    # 入力されたpartが空の場合はdestroyする
    param = strong_params
    return destroy unless param
    return destroy unless param.include?('parts_attributes')
    return destroy if param[:parts_attributes].flatten.select do |item|
      item.class != 'String' &&
          item['_destroy'] == 'false'
    end.length == 0

    if @symptom.update(param)
      redirect_to action: 'index', notice: '更新しました'
    else
      render :edit
    end
  end

  def destroy
    @symptom = current_user.symptom.find(params[:id])
    if @symptom.destroy!
      redirect_to action: 'index', notice: '削除しました'
    end
  end


  private

  def strong_params
    
    # 何も入力していない場合にエラーが出るため、strong_parameterしない。
    return unless params.include?('symptom')
    params.require(:symptom).permit(:parts_attributes => [:memo, :front_or_back, :x, :y, :_destroy])
  end

end
