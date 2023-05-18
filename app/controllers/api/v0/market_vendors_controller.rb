class Api::V0::MarketVendorsController < ApplicationController
  def create
    MarketVendor.create!(market_vendor_params)
    render_success_response
  end

  private

  def market_vendor_params
    params.require(:market_vendor).permit(:market_id, :vendor_id)
  end

  def render_success_response
    render json: { message: 'Successfully added vendor to market' }, status: 201
  end
end
