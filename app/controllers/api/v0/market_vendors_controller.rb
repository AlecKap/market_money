class Api::V0::MarketVendorsController < ApplicationController
  def create
    begin
      MarketVendor.create!(market_vendor_params)
      render_success_response
    rescue ActiveRecord::RecordInvalid => error
      render_error_response(error, market_vendor_params)
    end
  end

  private

  def market_vendor_params
    params.require(:market_vendor).permit(:market_id, :vendor_id)
  end

  def render_success_response
    render json: { message: 'Successfully added vendor to market' }, status: 201
  end

  def render_error_response

  end
end
