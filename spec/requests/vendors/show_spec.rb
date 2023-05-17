require 'rails_helper'

describe 'can get one vendor by its id' do
  it 'returns a vendor with valid id' do
    id = create(:vendor).id

    get "/api/v0/vendors/#{id}"

    expect(response).to be_successful

    vendor = JSON.parse(response.body, symbolize_names: true)

    vendor_data = vendor[:data]

    expect(vendor_data).to have_key(:id)
    expect(vendor_data[:id]).to be_an(String)

    vendor_atrb = vendor_data[:attributes]

    expect(vendor_atrb).to have_key(:name)
    expect(vendor_atrb).to have_key(:description)
    expect(vendor_atrb).to have_key(:contact_name)
    expect(vendor_atrb).to have_key(:contact_phone)
    expect(vendor_atrb).to have_key(:credit_accepted)

    expect(vendor_atrb[:name]).to be_a(String)
    expect(vendor_atrb[:description]).to be_a(String)
    expect(vendor_atrb[:contact_name]).to be_a(String)
    expect(vendor_atrb[:contact_phone]).to be_a(String)
    expect(vendor_atrb[:credit_accepted]).to be_in([true, false])
  end

  it 'invalid vendor id returns a 404 error' do
    id = 12122332343

    get "/api/v0/vendors/#{id}"

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    error_data = JSON.parse(response.body, symbolize_names: true)

    expect(error_data).to have_key(:errors)

    error_detail = error_data[:errors]

    expect(error_detail).to be_an(Array)
    expect(error_detail[0][:details]).to eq("Couldn't find Vendor with 'id'=#{id}")
  end
end
