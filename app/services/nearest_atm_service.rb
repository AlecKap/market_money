class NearestAtmService
  def nearest_atms(lat, lon)
    get_url("/search/2/categorySearch/cash_dispenser.json?lat=#{lat}&lon=#{lon}")
  end

  private

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.tomtom.com') do |faraday|
      faraday.params['key'] = "#{ENV['atm_key']}"
    end
  end
end
