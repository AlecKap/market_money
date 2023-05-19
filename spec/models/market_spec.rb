require 'rails_helper'

RSpec.describe Market, type: :model do
  describe 'relationships' do
    it { should have_many :market_vendors }
    it { should have_many(:vendors).through(:market_vendors) }
  end

  describe 'Class Methods' do
    before :each do
      market_test_data
    end

    describe 'by_state' do
      it 'returns an array of markets with states matching the query params' do
        test_params1 = { state: 'Colorado' }
        test_params2 = { state: 'Colo' }
        test_params3 = { state: 'colorado' }

        expect(Market.by_state(test_params1)).to eq([@market1, @market2, @market4, @market6])
        expect(Market.by_state(test_params2)).to eq([@market1, @market2, @market4, @market6])
        expect(Market.by_state(test_params3)).to eq([@market1, @market2, @market4, @market6])
      end
    end

    describe 'by_state_and_city' do
      it 'returns an array of markets with states matching the query params' do
        test_params1 = {
          state: 'Colorado',
          city: 'Broomfield'
        }
        test_params2 = {
          state: 'Color',
          city: 'Broom'
        }
        test_params3 = {
          state: 'colorado',
          city: 'broomfield'
        }

        expect(Market.by_state_and_city(test_params1)).to eq([@market2, @market4])
        expect(Market.by_state_and_city(test_params2)).to eq([@market2, @market4])
        expect(Market.by_state_and_city(test_params3)).to eq([@market2, @market4])
      end
    end

    describe 'by_state_city_and_name' do
      it 'returns an array of markets with states matching the query params' do
        test_params1 = {
          state: 'Colorado',
          city: 'Broomfield',
          name: 'King Soopers'
        }
        test_params2 = {
          state: 'Color',
          city: 'Broom',
          name: 'King Soop'
        }
        test_params3 = {
          state: 'colorado',
          city: 'broomfield',
          name: 'king Soopers'
        }

        expect(Market.by_state_city_and_name(test_params1)).to eq([@market4])
        expect(Market.by_state_city_and_name(test_params2)).to eq([@market4])
        expect(Market.by_state_city_and_name(test_params3)).to eq([@market4])
      end
    end

    describe 'by_state_and_name' do
      it 'returns an array of markets with states matching the query params' do
        test_params1 = {
          state: 'Colorado',
          name: 'King Soopers'
        }
        test_params2 = {
          state: 'Color',
          name: 'King soop'
        }
        test_params3 = {
          state: 'colorado',
          name: 'king soopers'
        }

        expect(Market.by_state_and_name(test_params1)).to eq([@market1, @market4])
        expect(Market.by_state_and_name(test_params2)).to eq([@market1, @market4])
        expect(Market.by_state_and_name(test_params3)).to eq([@market1, @market4])
      end
    end


    describe 'by_name' do
      it 'returns an array of markets with names matching the query params' do
        test_params1 = { name: 'King Soopers' }
        test_params2 = { name: 'King Soop' }
        test_params3 = { name: 'king soopers' }

        expect(Market.by_name(test_params1)).to eq([@market1, @market4])
        expect(Market.by_name(test_params2)).to eq([@market1, @market4])
        expect(Market.by_name(test_params3)).to eq([@market1, @market4])
      end
    end
  end

  describe 'instance methods' do
    describe 'vendor_count' do
      it 'returns a markets count of vendors' do
        test_data
        expect(@market1.vendor_count).to eq(3)
      end
    end
  end
end
