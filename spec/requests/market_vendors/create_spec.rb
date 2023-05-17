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

# describe 'can NOT create a new vendor' do
#   it 'invalid vendor creation input returns a status 400 error' do
#     vendor_params = ({
#       name: 'RoketsRUs',
#       description: '',
#       contact_name: 'Johnny Rokets',
#       contact_phone: '',
#       credit_accepted: false
#       })
#     headers = { 'CONTENT_TYPE' => 'application/json' }

#     post '/api/v0/vendors', headers: headers, params: JSON.generate(vendor: vendor_params)

#     expect(response).to_not be_successful
#     expect(response.status).to eq(400)

#     error_data = JSON.parse(response.body, symbolize_names: true)

#     expect(error_data).to have_key(:errors)

#     error_detail = error_data[:errors]

#     expect(error_detail).to be_an(Array)
#     expect(error_detail[0][:details]).to eq("Validation failed: Description can't be blank, Contact phone can't be blank")
#   end
# end
