require 'rails_helper'

describe 'can update an existing vendor' do
  it 'with a valid vendor id and valid input' do
    id = create(:vendor).id
    previous_name = Vendor.last.name
    vendor_params = { name: 'Super Kings' }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    patch "/api/v0/vendors/#{id}", headers: headers, params: JSON.generate({ vendor: vendor_params })
    vendor = Vendor.find_by(id: id)

    expect(response).to be_successful
    expect(vendor.name).to_not eq(previous_name)
    expect(vendor.name).to eq('Super Kings')
  end
end

describe 'can NOT update an existing vendor' do
  it 'updating with invalid vendor input returns a status 400 error' do
    id = create(:vendor).id
    vendor_params = { name: '' }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    patch "/api/v0/vendors/#{id}", headers: headers, params: JSON.generate(vendor_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    error_data = JSON.parse(response.body, symbolize_names: true)

    expect(error_data).to have_key(:errors)

    error_detail = error_data[:errors]

    expect(error_detail).to be_an(Array)
    expect(error_detail[0][:details]).to eq("Validation failed: Name can't be blank")
  end

  it 'updating with invalid vendor id returns a status 404 error' do
    id = 12313878457734332
    vendor_params = { name: 'Super Market Express' }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    patch "/api/v0/vendors/#{id}", headers: headers, params: JSON.generate(vendor_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    error_data = JSON.parse(response.body, symbolize_names: true)

    expect(error_data).to have_key(:errors)

    error_detail = error_data[:errors]

    expect(error_detail).to be_an(Array)
    expect(error_detail[0][:details]).to eq("Couldn't find Vendor with 'id'=#{id}")
  end
end
