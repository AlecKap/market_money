class Api::V0::Markets::NearestAtmsController < ApplicationController
  def index
    # binding.pry
    market = Market.find(params[:market_id])
    render json: AtmSerializer.new(NearestAtmsFacade.new(market).atms)
  end
end