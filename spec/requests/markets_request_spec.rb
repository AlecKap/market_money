require 'rails_helper'

describe 'Market API' do
  it 'sends a list of markets' do
    create_list(:market, 3)

    get '/api/v0/markets'

    expect(response).to be_successful

    markets = JSON.parse(response.body, symbolize_names: true)

    expect(markets[:data].count).to eq(3)

    markets[:data].each do |market|
      expect(market).to have_key(:id) # Ask about this checkin, is this redundnant
      expect(market[:id]).to be_an(String)
    
      market_atrb = market[:attributes]

      expect(market_atrb).to have_key(:name)
      expect(market_atrb[:name]).to be_a(String)

      expect(market_atrb).to have_key(:street)
      expect(market_atrb[:street]).to be_a(String)

      expect(market_atrb).to have_key(:city)
      expect(market_atrb[:city]).to be_a(String)

      expect(market_atrb).to have_key(:county)
      expect(market_atrb[:county]).to be_a(String)

      expect(market_atrb).to have_key(:state)
      expect(market_atrb[:state]).to be_an(String)

      expect(market_atrb).to have_key(:zip)
      expect(market_atrb[:zip]).to be_an(String)

      expect(market_atrb).to have_key(:lat)
      expect(market_atrb[:lat]).to be_an(String)

      expect(market_atrb).to have_key(:lon)
      expect(market_atrb[:lon]).to be_an(String)

      expect(market_atrb).to have_key(:vendor_count)
      expect(market_atrb[:vendor_count]).to be_an(Integer)
    end
  end
end
