class PlaidResponseMock 
  attr_reader :access_token

  def initialize(access_token)
    @access_token = access_token
  end

  def [](key)
  end
end