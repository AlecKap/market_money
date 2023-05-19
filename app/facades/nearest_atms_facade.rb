class NearestAtmsFacade
  def initialize(market)
    @lat = market.lat
    @lon = market.lon
  end

  def atms
    atm_details[:results].map do |atm|
      Atm.new(atm)
    end
  end

  private

  def service
    @_service ||= NearestAtmService.new
  end

  def atm_details
    @_atm_details ||= service.nearest_atms(@lat, @lon)
  end
end
