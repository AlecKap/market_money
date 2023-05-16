require 'rails_helper'

RSpec.describe Market, type: :model do
  it { should have_many :market_vendors }
  it { should have_many(:vendors).through(:market_vendors) }

  describe 'instance methods' do
    describe 'vendor_count' do
      it 'returns a markets count of vendors' do
        market1 = create(:market)
        vendor1 = create(:vendor)
        vendor2 = create(:vendor)
        vendor3 = create(:vendor)
        vendor4 = create(:vendor)
        create(:market_vendor, market: market1, vendor: vendor1)
        create(:market_vendor, market: market1, vendor: vendor2)
        create(:market_vendor, market: market1, vendor: vendor3)

        expect(market1.vendor_count).to eq(3)
      end
    end
  end
end