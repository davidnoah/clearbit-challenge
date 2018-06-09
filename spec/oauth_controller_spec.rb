require "rspec"
require "rack/test"
require_relative "./mocks/plaid_response_mock"

OUTER_APP = Rack::Builder.parse_file("config.ru").first

describe "OAuthController" do
  include Rack::Test::Methods

  def app
    OUTER_APP
  end

  def get_post_response(public_token)
    data = {
      public_token: public_token
    }
    post "/oauth/access-token", data
    JSON.parse(last_response.body)
  end

  it "Sends Bad Request on improper params" do
    body = get_post_response(nil)

    expect(last_response.status).to eq(400)
    expect(body.keys).to contain_exactly("message", "errors")
    expect(body["message"]).to eq("Parameter public_token is required")
  end

  it "Halts request when Plaid client throws error" do
    body = get_post_response("bad_access_token-kwejbwkjceb")
  
    expect(last_response.status).to eq(500)
    expect(body["message"]).to eq("provided public token is in an invalid format. expected format: public-<environment>-<identifier>")
  end

  it "Returns proper response" do
    allow_any_instance_of(PlaidClient).to receive(:exchange_public_token).and_return(PlaidResponseMock.new('some_access_token'))
    body = get_post_response("good_access_token-kwejbwkjceb")

    expect(last_response.status).to eq(200)
    expect(body["access_token"]).to eq('some_access_token')
  end
end