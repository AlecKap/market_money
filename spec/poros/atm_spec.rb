require 'rails_helper'

RSpec.describe Atm do
  it 'exists and has attributes' do
    attrs = {
      id: nil,
      poi: {
        name: 'atm'
      },
      address: {
        freeformAddress: '1234 Street St Cityton, USA, 9760405'
      },
      position: {
        lat: 37.038574,
        lon: -104.959644
      },
      dist: 169.76556
    }

    atm = Atm.new(attrs)

    expect(atm.id).to eq(nil)
    expect(atm.name).to eq('atm')
    expect(atm.address).to eq('1234 Street St Cityton, USA, 9760405')
    expect(atm.lat).to eq(37.038574)
    expect(atm.lon).to eq(-104.959644)
    expect(atm.distance).to eq(169.76556)
  end
end
