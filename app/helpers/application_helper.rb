module ApplicationHelper
  def track_url(campaign, cuepoint, event)
    # url = request.protocol + request.host_with_port + '/results/record?'
    # url += { campaign: campaign, cuepoint: @cuepoint, event: event }.to_query
    # url
    results_record_url(campaign: campaign.id, cuepoint: cuepoint.id, event: event)
  end

  def vast_url(cuepoint)
    # request.protocol + request.host_with_port + cuepoint_campaigns_path(@cuepoint) + '.xml'
    cuepoint_campaigns_url(cuepoint, format: :xml)
  end
end
