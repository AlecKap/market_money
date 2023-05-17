require 'rails_helper'

describe 'can destroy a vendor' do
  it 'will return a 204 status code with a valid id' do
    vendor = create(:vendor)

    expect { delete "/api/v0/vendors/#{vendor.id}" }.to change(Vendor, :count).by(-1)

    expect(response).to be_successful
    expect(response.status).to eq(204)

    expect { Vendor.find(vendor.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'deleting a vendor with invalid vendor id returns a status 404 error' do
    id = 12313878457734332

    expect { delete "/api/v0/vendors/#{id}" }.to change(Vendor, :count).by(0)

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    error_data = JSON.parse(response.body, symbolize_names: true)

    expect(error_data).to have_key(:errors)

    error_detail = error_data[:errors]

    expect(error_detail).to be_an(Array)
    expect(error_detail[0][:details]).to eq("Couldn't find Vendor with 'id'=#{id}")
  end
end
