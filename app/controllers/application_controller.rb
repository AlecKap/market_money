class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  private

  def not_found(error)
    render json: ErrorSerializer.serializer(error), status: :not_found
  end

  def record_invalid(error)
    if error.to_s.include?('exist')
      if error.to_s.include?('blank')
        blank_field(error)
      else
        not_found(error)
      end
    elsif params.key?(:market_vendor)
      prexisting_relation_error
    else
      blank_field(error)
    end
  end

  def prexisting_relation_error
    market_id = params[:market_vendor][:market_id]
    vendor_id = params[:market_vendor][:vendor_id]
    render json: ErrorSerializer.serialize_unique(market_id, vendor_id), status: 422
  end

  def blank_field(error)
    render json: ErrorSerializer.serializer(error), status: :bad_request
  end
end
