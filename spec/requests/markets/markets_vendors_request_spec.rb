require 'rails_helper'

describe 'Market Vendors API' do
  describe 'sends a list of all vendors for a particular market' do
    it 'retunrs a list of vendors using a valid market id' do
      test_data

      get "/api/v0/markets/#{@market1.id}/vendors"

      expect(response).to be_successful

      vendors = JSON.parse(response.body, symbolize_names: true)

      expect(vendors[:data].count).to eq(3)

      vendors[:data].each do |vendor|
        expect(vendor).to have_key(:id) # Ask about this checkin, is this redundnant
        expect(vendor[:id]).to be_an(String)

        vendor_atrb = vendor[:attributes]

        expect(vendor_atrb).to have_key(:name)
        expect(vendor_atrb[:name]).to be_a(String)

        expect(vendor_atrb).to have_key(:description)
        expect(vendor_atrb[:description]).to be_a(String)

        expect(vendor_atrb).to have_key(:contact_name)
        expect(vendor_atrb[:contact_name]).to be_a(String)

        expect(vendor_atrb).to have_key(:contact_phone)
        expect(vendor_atrb[:contact_phone]).to be_a(String)

        expect(vendor_atrb).to have_key(:credit_accepted)
        expect(vendor_atrb[:credit_accepted]).to be_in([true, false])
      end
    end

    it 'invalid market id returns a 404 error' do
      id = 12122332343

      get "/api/v0/markets/#{id}/vendors"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data).to have_key(:errors)

      error_detail = error_data[:errors]

      expect(error_detail).to be_an(Array)
      expect(error_detail[0][:details]).to eq("Couldn't find Market with 'id'=#{id}")
    end
  end
end
