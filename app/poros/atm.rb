class Atm
  attr_reader :id,
              :name,
              :address,
              :lat,
              :lon,
              :distance

  def initialize(atrb)
    @id = nil
    @name = atrb[:poi][:name]
    @address = atrb[:address][:freeformAddress]
    @lat = atrb[:position][:lat]
    @lon = atrb[:position][:lon]
    @distance = atrb[:dist]
  end
end
