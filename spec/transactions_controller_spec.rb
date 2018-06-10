require "rspec"
require "rack/test"

OUTER_APP = Rack::Builder.parse_file("config.ru").first


describe "TransactionsController" do
  include Rack::Test::Methods

  def app
    OUTER_APP
  end

  def get_response(access_token, start_date, end_date)
    data = {
      access_token: access_token,
      start_date: start_date,
      end_date: end_date
    }
    get "/transactions", data
    JSON.parse(last_response.body)
  end

  it "Sends Bad Request when improper params are passed" do
    body = get_response(nil, "2017-01-01", "2017-06-07")

    expect(last_response.status).to eq(400)
    expect(body.keys).to contain_exactly("message", "errors")
    expect(body["message"]).to eq("Parameter access_token is required")
  end

  it "Halts request when Plaid client throws error" do
    body = get_response("bad-access_token", "2017-01-01", "2017-06-07")

    expect(last_response.status).to eq(500)
    expect(body["message"]).to eq("provided access token is in an invalid format. expected format: access-<environment>-<identifier>")
  end

  it "Returns proper response" do
    allow_any_instance_of(PlaidClient).to receive(:get_all_transactions).and_return({
      'transactions' => [
        {'name' => 'Clearbit', 'date' => '2018-06-05', 'amount' => 82},
        {'name' => 'Clearbit', 'date' => '2018-05-05', 'amount' => 82}
      ]
    })
    allow_any_instance_of(ClearbitClient).to receive(:name_to_domain).and_return({"name"=>"CompanyName", "domain"=>"www.domain.com", "logo"=>"https://logo.clearbit.com/logo.com"})

    body = get_response('some-access-token', '2018-05-05', '2018-06-05')
  end
end