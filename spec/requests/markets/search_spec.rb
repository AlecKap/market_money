require 'rails_helper'

describe 'Market Search API' do
  before :each do
    market_test_data
  end

  describe 'can search fo markets with valid search params.' do
    it 'CAN search by state' do

      headers = { 'CONTENT_TYPE' => 'application/json' }
      get '/api/v0/markets/search?state=Colorado', headers: headers

      expect(response).to be_successful

      markets = JSON.parse(response.body, symbolize_names: true)

      expect(markets[:data]).to be_an(Array)
      expect(markets[:data].sample).to be_a(Hash)
      expect(markets[:data].count).to eq(4)

      markets[:data].each do |market|
        expect(market).to be_a(Hash)
        expect(market).to have_key(:id)
        expect(market[:id]).to be_an(String)

        market_atrb = market[:attributes]

        expect(market_atrb).to have_key(:name)
        expect(market_atrb).to have_key(:street)
        expect(market_atrb).to have_key(:city)
        expect(market_atrb).to have_key(:county)
        expect(market_atrb).to have_key(:state)
        expect(market_atrb).to have_key(:zip)
        expect(market_atrb).to have_key(:lat)
        expect(market_atrb).to have_key(:lon)
        expect(market_atrb).to have_key(:vendor_count)

        expect(market_atrb[:name]).to be_a(String)
        expect(market_atrb[:street]).to be_a(String)
        expect(market_atrb[:city]).to be_a(String)
        expect(market_atrb[:county]).to be_a(String)
        expect(market_atrb[:state]).to be_an(String)
        expect(market_atrb[:zip]).to be_an(String)
        expect(market_atrb[:lat]).to be_an(String)
        expect(market_atrb[:lon]).to be_an(String)
        expect(market_atrb[:vendor_count]).to be_an(Integer)
      end
    end

    it 'CAN search by state and city' do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      get '/api/v0/markets/search?state=Colorado&city=Broomfield', headers: headers

      expect(response).to be_successful

      markets = JSON.parse(response.body, symbolize_names: true)

      expect(markets[:data]).to be_an(Array)
      expect(markets[:data].sample).to be_a(Hash)
      expect(markets[:data].count).to eq(2)

      markets[:data].each do |market|
        expect(market).to be_a(Hash)
        expect(market).to have_key(:id)
        expect(market[:id]).to be_an(String)

        market_atrb = market[:attributes]

        expect(market_atrb).to have_key(:name)
        expect(market_atrb).to have_key(:street)
        expect(market_atrb).to have_key(:city)
        expect(market_atrb).to have_key(:county)
        expect(market_atrb).to have_key(:state)
        expect(market_atrb).to have_key(:zip)
        expect(market_atrb).to have_key(:lat)
        expect(market_atrb).to have_key(:lon)
        expect(market_atrb).to have_key(:vendor_count)

        expect(market_atrb[:name]).to be_a(String)
        expect(market_atrb[:street]).to be_a(String)
        expect(market_atrb[:city]).to be_a(String)
        expect(market_atrb[:county]).to be_a(String)
        expect(market_atrb[:state]).to be_an(String)
        expect(market_atrb[:zip]).to be_an(String)
        expect(market_atrb[:lat]).to be_an(String)
        expect(market_atrb[:lon]).to be_an(String)
        expect(market_atrb[:vendor_count]).to be_an(Integer)
      end
    end

    it 'CAN search by state, city, and name' do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      get '/api/v0/markets/search?state=Colorado&city=Broomfield&name=King Soopers', headers: headers

      expect(response).to be_successful

      markets = JSON.parse(response.body, symbolize_names: true)

      expect(markets[:data]).to be_an(Array)
      expect(markets[:data].sample).to be_a(Hash)
      expect(markets[:data].count).to eq(1)

      markets[:data].each do |market|
        expect(market).to be_a(Hash)
        expect(market).to have_key(:id)
        expect(market[:id]).to be_an(String)

        market_atrb = market[:attributes]

        expect(market_atrb).to have_key(:name)
        expect(market_atrb).to have_key(:street)
        expect(market_atrb).to have_key(:city)
        expect(market_atrb).to have_key(:county)
        expect(market_atrb).to have_key(:state)
        expect(market_atrb).to have_key(:zip)
        expect(market_atrb).to have_key(:lat)
        expect(market_atrb).to have_key(:lon)
        expect(market_atrb).to have_key(:vendor_count)

        expect(market_atrb[:name]).to be_a(String)
        expect(market_atrb[:street]).to be_a(String)
        expect(market_atrb[:city]).to be_a(String)
        expect(market_atrb[:county]).to be_a(String)
        expect(market_atrb[:state]).to be_an(String)
        expect(market_atrb[:zip]).to be_an(String)
        expect(market_atrb[:lat]).to be_an(String)
        expect(market_atrb[:lon]).to be_an(String)
        expect(market_atrb[:vendor_count]).to be_an(Integer)
      end
    end

    it 'CAN search by state and name' do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      get '/api/v0/markets/search?state=Colorado&name=King Soopers', headers: headers

      expect(response).to be_successful

      markets = JSON.parse(response.body, symbolize_names: true)

      expect(markets[:data]).to be_an(Array)
      expect(markets[:data].sample).to be_a(Hash)
      expect(markets[:data].count).to eq(2)

      markets[:data].each do |market|
        expect(market).to be_a(Hash)
        expect(market).to have_key(:id)
        expect(market[:id]).to be_an(String)

        market_atrb = market[:attributes]

        expect(market_atrb).to have_key(:name)
        expect(market_atrb).to have_key(:street)
        expect(market_atrb).to have_key(:city)
        expect(market_atrb).to have_key(:county)
        expect(market_atrb).to have_key(:state)
        expect(market_atrb).to have_key(:zip)
        expect(market_atrb).to have_key(:lat)
        expect(market_atrb).to have_key(:lon)
        expect(market_atrb).to have_key(:vendor_count)

        expect(market_atrb[:name]).to be_a(String)
        expect(market_atrb[:street]).to be_a(String)
        expect(market_atrb[:city]).to be_a(String)
        expect(market_atrb[:county]).to be_a(String)
        expect(market_atrb[:state]).to be_an(String)
        expect(market_atrb[:zip]).to be_an(String)
        expect(market_atrb[:lat]).to be_an(String)
        expect(market_atrb[:lon]).to be_an(String)
        expect(market_atrb[:vendor_count]).to be_an(Integer)
      end
    end

    it 'CAN search by name' do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      get '/api/v0/markets/search?name=King Soopers', headers: headers

      expect(response).to be_successful

      markets = JSON.parse(response.body, symbolize_names: true)

      expect(markets[:data]).to be_an(Array)
      expect(markets[:data].sample).to be_a(Hash)
      expect(markets[:data].count).to eq(2)

      markets[:data].each do |market|
        expect(market).to be_a(Hash)
        expect(market).to have_key(:id)
        expect(market[:id]).to be_an(String)

        market_atrb = market[:attributes]

        expect(market_atrb).to have_key(:name)
        expect(market_atrb).to have_key(:street)
        expect(market_atrb).to have_key(:city)
        expect(market_atrb).to have_key(:county)
        expect(market_atrb).to have_key(:state)
        expect(market_atrb).to have_key(:zip)
        expect(market_atrb).to have_key(:lat)
        expect(market_atrb).to have_key(:lon)
        expect(market_atrb).to have_key(:vendor_count)

        expect(market_atrb[:name]).to be_a(String)
        expect(market_atrb[:street]).to be_a(String)
        expect(market_atrb[:city]).to be_a(String)
        expect(market_atrb[:county]).to be_a(String)
        expect(market_atrb[:state]).to be_an(String)
        expect(market_atrb[:zip]).to be_an(String)
        expect(market_atrb[:lat]).to be_an(String)
        expect(market_atrb[:lon]).to be_an(String)
        expect(market_atrb[:vendor_count]).to be_an(Integer)
      end
    end

    it 'if there is only one market, it is returned as an array with one market' do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      get '/api/v0/markets/search?state=Colorado&city=Broomfield&name=King Soopers', headers: headers

      expect(response).to be_successful

      markets = JSON.parse(response.body, symbolize_names: true)

      expect(markets[:data]).to be_an(Array)
      expect(markets[:data].sample).to be_a(Hash)
      expect(markets[:data].count).to eq(1)
    end

    it 'if there are no markets returned, the data top level key is an empty array, and a 200 status code is returned.' do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      get '/api/v0/markets/search?state=Colorado&city=Broomfield&name=Cub Foodz', headers: headers

      expect(response).to be_successful

      markets = JSON.parse(response.body, symbolize_names: true)

      expect(markets[:data]).to be_an(Array)
      expect(markets[:data].count).to eq(0)
    end
  end

  describe 'returns a 422 status code if sent invalid parameters' do
    it 'CANNOT search by just city' do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      get '/api/v0/markets/search?city=Broomfield', headers: headers

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      error_data = JSON.parse(response.body, symbolize_names: true)

     expect(error_data).to have_key(:errors)

      error_detail = error_data[:errors]

      expect(error_detail).to be_an(Array)
      expect(error_detail[0][:details]).to eq('Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.')
    end

    it 'CANNOT search by just city and a name' do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      get '/api/v0/markets/search?city=Broomfield&name=King Soopers', headers: headers

      expect(response).to_not be_successful
      expect(response.status).to eq(422)
  
      error_data = JSON.parse(response.body, symbolize_names: true)
  
      expect(error_data).to have_key(:errors)
  
      error_detail = error_data[:errors]
  
      expect(error_detail).to be_an(Array)
      expect(error_detail[0][:details]).to eq('Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.')
    end
  end
end
