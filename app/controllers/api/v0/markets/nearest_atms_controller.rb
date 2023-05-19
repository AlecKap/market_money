class Api::V0::Markets::NearestAtmsController < ApplicationController
  def index
    market = Market.find(params[:market_id])
    render json: AtmSerializer.new(NearestAtmsFacade.new(market).atms)
  end
end
