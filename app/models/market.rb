class Market < ApplicationRecord
  has_many :market_vendors
  has_many :vendors, through: :market_vendors

  def self.by_state(params)
    where('state ILIKE ?', "%#{params[:state]}%")
  end

  def self.by_state_and_city(params)
    where('state ILIKE :state AND city ILIKE :city',
          state: "%#{params[:state]}%",
          city: "%#{params[:city]}%")
  end

  def self.by_state_city_and_name(params)
    where('state ILIKE :state AND city ILIKE :city AND name ILIKE :name',
          state: "%#{params[:state]}%",
          city: "%#{params[:city]}%",
          name: "%#{params[:name]}%")
  end

  def self.by_state_and_name(params)
    where('state ILIKE :state AND name ILIKE :name',
          state: "%#{params[:state]}%",
          name: "%#{params[:name]}%")
  end

  def self.by_name(params)
    where('name ILIKE ?', "%#{params[:name]}%")
  end

  def vendor_count
    vendors.count
  end
end
