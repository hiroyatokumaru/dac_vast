# キャンペーン用コントローラ
class CampaignsController < ApplicationController
  before_action :set_campaign, only:[:edit, :update, :destroy]
  
  # 一覧表示
  def index
    unless params[:cuepoint_id]
      @campaigns = Campaign.all
    else
      # 下記はVAST URL呼び出しを想定
      # TODO
      @cuepoint = Cuepoint.find(params[:cuepoint_id])
      @campaigns = Campaign.current_avaliable(@cuepoint)
      response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
      response.headers['Access-Control-Allow-Methods'] = 'GET'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Credentials'] = 'true'
      headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type'
    end
  end

  # 新規
  def new
    @campaign = Campaign.new
  end

  # 作成
  def create
     @campaign = Campaign.new(campaign_params)
    
    if @campaign.save
      flash[:success] = 'Message が正常に投稿されました'
      redirect_to campaigns_path
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
    if @campaign.update(campaign_params)
      flash[:success] = 'Message は正常に更新されました'
      redirect_to campaigns_path
    else
      flash.now[:danger] = 'Message は更新されませんでした'
      render :edit
    end
  end

  # 削除
  def destroy
    @campaign.destroy
    
    flash[:success] = 'Message は正常に削除されました'
    redirect_to campaigns_url
  end

  private
    # キャンペーン用パラメータ
    def campaign_params
      params[:campaign].permit(
        :name, :start_at, :end_at, :limit_start, :movie_url, :cuepoint_ids => []
      )
    end
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end
end
