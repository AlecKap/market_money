require 'rails_helper'

RSpec.describe Market, type: :model do
  it { should have_many :market_vendors }
  it { should have_many(:vendors).through(:market_vendors) }

  describe 'instance methods' do
    describe 'vendor_count' do
      it 'returns a markets count of vendors' do
        test_data

        expect(@market1.vendor_count).to eq(3)
      end
    end
  end
end
