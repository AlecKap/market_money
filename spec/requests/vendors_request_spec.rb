require 'rails_helper'

describe 'Vendor API' do
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

  describe 'can create a new vendor' do
    it 'with valid information' do
      vendor_params = ({
        name: 'Murder on the Orient Express',
        description: 'Agatha Christie',
        contact_name: 'mystery',
        contact_phone: 'Filled with suspense.',
        credit_accepted: true
        })
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

    it 'invalid vendor creation input returns a status 400 error' do
      vendor_params = ({
        name: 'Murder on the Orient Express',
        description: '',
        contact_name: 'mystery',
        contact_phone: '',
        credit_accepted: false
        })
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

  describe 'can update an existing book' do
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
end
