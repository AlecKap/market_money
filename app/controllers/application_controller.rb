class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  private

  def not_found(error)
    render json: ErrorSerializer.serializer(error), status: 404
  end

  def record_invalid(error)
    render json: ErrorSerializer.serializer(error), status: 400
  end
end
