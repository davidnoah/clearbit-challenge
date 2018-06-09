require "rspec"
require "rack/test"

OUTER_APP = Rack::Builder.parse_file("config.ru").first

describe "OAuthController" do
  include Rack::Test::Methods

  def app
    OUTER_APP
  end

  it "Sends Bad Request on improper params" do
    data = {
      'public_token' => nil
    }
    post "/oauth/access-token", data.to_json, "CONTENT_TYPE" => "application/json"

    expect(last_response.status).to eq(400)
  end
end