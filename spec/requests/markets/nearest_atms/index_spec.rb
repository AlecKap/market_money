require 'rails_helper'

describe 'Market API' do
  describe 'CAN get cash dispensers naer a market' do
    it 'with a valid market id', :vcr do
      market_test_data
      headers = { 'CONTENT_TYPE' => 'application/json' }
      get "/api/v0/markets/#{@market1.id}/nearest_atms", headers: headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      atms = JSON.parse(response.body, symbolize_names: true)

      expect(atms[:data]).to be_an(Array)
      expect(atms[:data].sample).to be_a(Hash)
      expect(atms[:data].count).to eq(10)

      atms[:data].each do |atm|
        expect(atm).to be_a(Hash)
        expect(atm).to have_key(:id)
        expect(atm[:id]).to eq(nil)
        expect(atm[:type]).to be_an(String)
        expect(atm[:attributes]).to be_a(Hash)

        atm_atrb = atm[:attributes]

        expect(atm_atrb).to have_key(:name)
        expect(atm_atrb).to have_key(:address)
        expect(atm_atrb).to have_key(:lat)
        expect(atm_atrb).to have_key(:lon)
        expect(atm_atrb).to have_key(:distance)

        expect(atm_atrb[:name]).to be_a(String)
        expect(atm_atrb[:address]).to be_a(String)
        expect(atm_atrb[:lat]).to be_an(Float)
        expect(atm_atrb[:lon]).to be_an(Float)
        expect(atm_atrb[:distance]).to be_an(Float)
      end
    end
  end
end
