class Api::V0::Markets::SearchesController < ApplicationController
  def show
    if params.key?(:state) && !params.key?(:city) && !params.key?(:name)
      render json: MarketSerializer.new(Market.by_state(params))
    elsif params.key?(:state) && params.key?(:city) && !params.key?(:name)
      serialize(Market.by_state_and_city(params))
    elsif params.key?(:state) && params.key?(:city) && params.key?(:name)
      serialize(Market.by_state_city_and_name(params))
    elsif params.key?(:state) && !params.key?(:city) && params.key?(:name)
      serialize(Market.by_state_and_name(params))
    elsif  !params.key?(:state) && !params.key?(:city) && params.key?(:name)
      serialize(Market.by_name(params))
    else
      invalid_search_response
    end
  end

  private

  def serialize(search_params)
    render json: MarketSerializer.new(search_params)
  end

  def invalid_search_response
    render json: ErrorSerializer.new.invalid_search_parameters_response, status: 422
  end

end