class ErrorSerializer
  def self.serializer(error)
    {
      errors: [
        {
          details: error
        }
      ]
    }
  end

  def self.serialize_unique(market_id, vendor_id)
    message = "Validation failed: Market vendor asociation between market with market_id=#{market_id} and vendor_id=#{vendor_id} already exists"
    serializer(message)
  end
end
