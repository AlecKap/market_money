class Api::V0::VendorsController < ApplicationController
  before_action :find_vendor, only: [:show, :update, :destroy]

  def show
    render json: VendorSerializer.new(@vendor)
  end

  def create # consider move to Market::VendorsController
    render json: VendorSerializer.new(Vendor.create!(vendor_params)), status: :created
  end

  def update # consider move to Market::VendorsController
    @vendor.update!(vendor_params)
    render json: VendorSerializer.new(@vendor)
  end

  def destroy # consider move to Market::VendorsController
    render json: @vendor.delete, status: 204
  end

  private

  def find_vendor
    @vendor = Vendor.find(params[:id])
  end

  def vendor_params
    params.require(:vendor).permit(:name,
                                   :description,
                                   :contact_name,
                                   :contact_phone,
                                   :credit_accepted)
  end
end
