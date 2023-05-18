require 'rails_helper'

describe 'Destroy MarketVendor' do
  it 'will return a 204 status upon successful deletion' do
    test_data

    expect(@market4.vendors.count).to eq(1)
    expect(@market4.vendors).to eq([@vendor3])

    market_vendor_params = {
      market_id: @market4.id,
      vendor_id: @vendor3.id
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }
    delete '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

    expect(response).to be_successful
    expect(response.status).to eq(204)

    get "/api/v0/markets/#{@market4.id}/vendors"

    vendors = JSON.parse(response.body, symbolize_names: true)

    expect(vendors[:data].count).to eq(0)
    expect(vendors[:data]).to eq([])
    expect(@vendor3.markets.count).to eq(1)
    expect(@vendor3.markets).to eq([@market1])
    expect { MarketVendor.find(@market_vendor8.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
  
  it 'will return a 404 error with invalid ids' do
    market_vendor_params = {
      market_id: 4564675,
      vendor_id: 546745674567
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }
    delete '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    error_data = JSON.parse(response.body, symbolize_names: true)

    expect(error_data).to have_key(:errors)

    error_detail = error_data[:errors]
    
    expect(error_detail).to be_an(Array)
    expect(error_detail[0][:details]).to eq("No MarketVendor with market_id=4564675 AND vendor_id=546745674567 exists")
  end

  it 'will return a 404 error with blank ids' do
    market_vendor_params = {
      market_id: "",
      vendor_id: 546745674567
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }
    delete '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    error_data = JSON.parse(response.body, symbolize_names: true)

    expect(error_data).to have_key(:errors)

    error_detail = error_data[:errors]

    expect(error_detail).to be_an(Array)
    expect(error_detail[0][:details]).to eq("No MarketVendor with market_id= AND vendor_id=546745674567 exists")
  end

  it 'will return a 404 error with valid ids that share no relation' do
    test_data
    market_vendor_params = {
      market_id: @market1.id,
      vendor_id: @vendor6.id
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }
    delete '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    error_data = JSON.parse(response.body, symbolize_names: true)

    expect(error_data).to have_key(:errors)

    error_detail = error_data[:errors]

    expect(error_detail).to be_an(Array)
    expect(error_detail[0][:details]).to eq("No MarketVendor with market_id=#{@market1.id} AND vendor_id=#{@vendor6.id} exists")
  end
end
