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
end
