require 'rails_helper'

describe 'can create a new vendor' do
  it 'with valid information' do
    vendor_params = {
      name: 'Murder on the Orient Express',
      description: 'Agatha Christie',
      contact_name: 'mystery',
      contact_phone: 'Filled with suspense.',
      credit_accepted: true
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v0/vendors', headers: headers, params: JSON.generate(vendor: vendor_params)

    created_vendor = Vendor.last

    expect(response).to be_successful
    expect(response.status).to eq(201)

    expect(created_vendor.name).to eq(vendor_params[:name])
    expect(created_vendor.description).to eq(vendor_params[:description])
    expect(created_vendor.contact_phone).to eq(vendor_params[:contact_phone])
    expect(created_vendor.contact_name).to eq(vendor_params[:contact_name])
    expect(created_vendor.credit_accepted).to eq(vendor_params[:credit_accepted])
  end
end

describe 'can NOT create a new vendor' do
  it 'invalid vendor creation input returns a status 400 error' do
    vendor_params = {
      name: 'RoketsRUs',
      description: '',
      contact_name: 'Johnny Rokets',
      contact_phone: '',
      credit_accepted: false
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v0/vendors', headers: headers, params: JSON.generate(vendor: vendor_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    error_data = JSON.parse(response.body, symbolize_names: true)

    expect(error_data).to have_key(:errors)

    error_detail = error_data[:errors]

    expect(error_detail).to be_an(Array)
    expect(error_detail[0][:details]).to eq("Validation failed: Description can't be blank, Contact phone can't be blank")
  end
end
