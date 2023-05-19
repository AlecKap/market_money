require 'rails_helper'

RSpec.describe NearestAtmsFacade do
  before :each do
    market_test_data
    @facade = NearestAtmsFacade.new(@market1)
  end

  describe 'atm details' do
    describe 'atms' do
      it 'returns an array of NearestAtms', :vcr do
        expect(@facade.atms).to be_an(Array)
        expect(@facade.atms.sample).to be_an(Atm)
        expect(@facade.atms.sample.name).to be_a(String)
        expect(@facade.atms.sample.address).to be_a(String)
        expect(@facade.atms.sample.lat).to be_a(Float)
        expect(@facade.atms.sample.lon).to be_a(Float)
        expect(@facade.atms.sample.distance).to be_a(Float)
      end
    end
  end
end
