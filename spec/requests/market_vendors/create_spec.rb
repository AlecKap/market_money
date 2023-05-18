require 'rails_helper'

describe 'can create a new MarketVendor' do
  it 'with valid information' do
    test_data

    get "/api/v0/markets/#{@market4.id}/vendors"

    vendors = JSON.parse(response.body, symbolize_names: true)

    expect(vendors[:data].count).to eq(1)
    expect(vendors[:data].first[:id]).to_not eq(@vendor6.id.to_s)

    market_vendor_params = {
      market_id: @market4.id,
      vendor_id: @vendor6.id
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

    created_market_vendor = MarketVendor.last
    status_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(201)

    expect(status_response).to have_key(:message)
    expect(status_response[:message]).to eq('Successfully added vendor to market')

    expect(created_market_vendor.market_id).to eq(market_vendor_params[:market_id])
    expect(created_market_vendor.vendor_id).to eq(market_vendor_params[:vendor_id])

    get "/api/v0/markets/#{@market4.id}/vendors"

    vendors = JSON.parse(response.body, symbolize_names: true)

    expect(vendors[:data].count).to eq(2)
    expect(vendors[:data].last[:id]).to eq(@vendor6.id.to_s)
  end
end

describe 'can NOT create a new market_vendor' do
  it 'invalid market_id or vendor_id returns a status 404 error' do
    test_data
    market_vendor_params = {
      market_id: @market4.id,
      vendor_id: 34536465766
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }
    post '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    error_data = JSON.parse(response.body, symbolize_names: true)

    expect(error_data).to have_key(:errors)

    error_detail = error_data[:errors]

    expect(error_detail).to be_an(Array)
    expect(error_detail[0][:details]).to eq('Validation failed: Vendor must exist')
  end

  it 'blank market_vendor creation input returns a status 400 error' do
    test_data
    market_vendor_params = {
      market_id: "",
      vendor_id: ""
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    error_data = JSON.parse(response.body, symbolize_names: true)

    expect(error_data).to have_key(:errors)

    error_detail = error_data[:errors]

    expect(error_detail).to be_an(Array)
    expect(error_detail[0][:details]).to eq("Validation failed: Market must exist, Vendor must exist, Market can't be blank, Vendor can't be blank")
  end

  it 'returns a status 422 error when relation already exists' do
    test_data
    market_vendor_params = {
      market_id: @market1.id,
      vendor_id: @vendor1.id
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(422)

    error_data = JSON.parse(response.body, symbolize_names: true)

    expect(error_data).to have_key(:errors)

    error_detail = error_data[:errors]

    expect(error_detail).to be_an(Array)
    expect(error_detail[0][:details]).to eq("Validation failed: Market vendor asociation between market with market_id=#{@market1.id} and vendor_id=#{@vendor1.id} already exists")
  end
end
