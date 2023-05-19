class Api::V0::Markets::SearchesController < ApplicationController
  def show
    successful_param_check1
    invalid_search_response
  end

  private

  def serialize(search_params)
    render json: MarketSerializer.new(search_params)
  end

  def invalid_response
    render json: ErrorSerializer.new.invalid_search_parameters_response, status: 422
  end

  def invalid_search_response # Put into module?
    invalid_response if !(params.key?(:state) && !params.key?(:city) && !params.key?(:name)) &&
                        !(params.key?(:state) && params.key?(:city) && !params.key?(:name)) &&
                        !(params.key?(:state) && params.key?(:city) && params.key?(:name)) &&
                        !(params.key?(:state) && !params.key?(:city) && params.key?(:name)) &&
                        !(!params.key?(:state) && !params.key?(:city) && params.key?(:name))
  end

  def successful_param_check1 # Put into module?
    serialize(Market.by_state(params)) if params.key?(:state) && !params.key?(:city) && !params.key?(:name)
    serialize(Market.by_state_and_city(params)) if params.key?(:state) && params.key?(:city) && !params.key?(:name)
    serialize(Market.by_state_city_and_name(params)) if params.key?(:state) && params.key?(:city) && params.key?(:name)
    serialize(Market.by_state_and_name(params)) if params.key?(:state) && !params.key?(:city) && params.key?(:name)
    serialize(Market.by_name(params)) if !params.key?(:state) && !params.key?(:city) && params.key?(:name)
  end
end
