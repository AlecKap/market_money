class Api::V0::MarketsController < ApplicationController
  before_action :find_market, only: :show

  def index
    render json: MarketSerializer.new(Market.all)
  end

  def show
    render json: MarketSerializer.new(@market)
  end

  private

  def find_market
    @market = Market.find(params[:id])
  end
end
