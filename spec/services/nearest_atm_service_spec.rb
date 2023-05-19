require 'rails_helper'

RSpec.describe NearestAtmService do
  context 'class methods' do
    context 'nearest_atms', :vcr do
      it 'returns atm data' do
        market_test_data
        lat = @market1.lat
        lon = @market1.lon
        search = NearestAtmService.new.nearest_atms(lat, lon)

        expect(search).to be_a(Hash)
        expect(search[:results]).to be_an(Array)

        atm_data = search[:results].first

        expect(atm_data).to be_a(Hash)
        expect(atm_data).to have_key(:id)
        expect(atm_data).to have_key(:type)
        expect(atm_data).to have_key(:poi)
        expect(atm_data[:poi]).to have_key(:name)
        expect(atm_data).to have_key(:address)
        expect(atm_data[:address]).to have_key(:freeformAddress)
        expect(atm_data).to have_key(:dist)
        expect(atm_data).to have_key(:position)
        expect(atm_data[:position]).to have_key(:lat)
        expect(atm_data[:position]).to have_key(:lon)

        expect(atm_data[:type]).to be_a(String)
        expect(atm_data[:poi]).to be_a(Hash)
        expect(atm_data[:poi][:name]).to be_a(String)
        expect(atm_data[:address]).to be_a(Hash)
        expect(atm_data[:address][:freeformAddress]).to be_a(String)
        expect(atm_data[:dist]).to be_a(Float)
        expect(atm_data[:position]).to be_a(Hash)
        expect(atm_data[:position][:lat]).to be_a(Float)
        expect(atm_data[:position][:lon]).to be_a(Float)
      end
    end
  end
end
