# キャンペーンクラス
class Campaign < ApplicationRecord
  has_and_belongs_to_many :cuepoints
  has_many :results, foreign_key: 'id', dependent: :destroy

  # 有効なキャンペーン一覧を返す
  #  - 対象のCue Pointと紐付いている。
  #  - キャンペーンが開始していて、終了する前。
  #  - Resultのスタート数(count_start)がキャンペーンの制限(limit_start)以内。
  # @param [Cuepoint, #read] cuepoint キャンペーンの対象となっている Cue Point
  # @return [Array] 該当キャンペーンの配列
  def self.current_avaliable(cuepoint)
      campaigns = cuepoint.campaigns.where("start_at <= '#{Time.now}' AND end_at >= '#{Time.now}'").to_a
      campaigns.delete_if do |campaign|
            result = Result.where(campaign: campaign, cuepoint: @cuepoint).first
            !result.blank? && result.count_start >= campaign.limit_start 
      end
  end
end
