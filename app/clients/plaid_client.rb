require 'plaid'

class PlaidClient
  def initialize
      @client = Plaid::Client.new(env: :sandbox,
                                  client_id: ENV['PLAID_CLIENT_ID'],
                                  secret: ENV['PLAID_SECRET'],
                                  public_key: ENV['PLAID_PUBLIC_KEY'])
  end

  def exchange_public_token(public_token)
    @client.item.public_token.exchange(public_token)
  end

  def get_all_transactions(access_token, start_date, end_date)
    begin
      response = @client.transactions.get(access_token, start_date, end_date)
      response["status_code"] = 200
    rescue Plaid::ItemError => error
      response = { status_code: error.error_code, message: error.error_message}
    end

    response
  end
end