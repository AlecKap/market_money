class Api::V0::MarketVendorsController < ApplicationController
  before_action :params_ids, only: [:destroy]
  def create
    MarketVendor.create!(market_vendor_params)
    render_success_response
  end

  def destroy
    begin
      MarketVendor.find_by!(market_vendor_params).destroy
    rescue ActiveRecord::RecordNotFound
      render json: ErrorSerializer.serializer(
        "No MarketVendor with market_id=#{@market_id} AND vendor_id=#{@vendor_id} exists"),
        status: :not_found
    end
  end

  private

  def market_vendor_params
    params.require(:market_vendor).permit(:market_id, :vendor_id)
  end

  def render_success_response
    render json: { message: 'Successfully added vendor to market' }, status: 201
  end

  def params_ids
    @market_id = params[:market_vendor][:market_id]
    @vendor_id = params[:market_vendor][:vendor_id]
  end
end
