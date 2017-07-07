# Cue Point コントローラ
class CuepointsController < ApplicationController
  before_action :set_cuepoint, only:[:edit, :update, :destroy]
  
  # 一覧
  def index
    @cuepoints = Cuepoint.order(created_at: :desc).page(params[:page]).per(3)
  end

  # 新規
  def new
    @cuepoint = Cuepoint.new
  end

  # 作成
  def create
    @cuepoint = Cuepoint.new(cuepoint_params)
    
    if @cuepoint.save
      flash[:success] = 'Message が正常に投稿されました'
      redirect_to cuepoints_path
    else
      flash.now[:danger] = 'Message が投稿されませんでした'
      render :new
    end
  end


  # 編集
  def edit
  end

  # 更新
  def update
    if @cuepoint.update(cuepoint_params)
      flash[:success] = 'Message は正常に更新されました'
      redirect_to cuepoints_path
    else
      flash.now[:danger] = 'Message は更新されませんでした'
      render :edit
    end
  end

  # 削除
  def destroy
    @cuepoint.destroy
    
    flash[:success] = 'Message は正常に削除されました'
    redirect_to cuepoints_url
  end

  private
    # キューポイント用パラメータ
    def cuepoint_params
      params.require(:cuepoint).permit(:name)
    end  
    
    def set_cuepoint
      @cuepoint = Cuepoint.find(params[:id])
    end
end
