require 'plaid'

# Client class that handles initialization and queries to the Plaid API
class PlaidClient
  def initialize
      @client = Plaid::Client.new(env: :sandbox,
                                  client_id: ENV['PLAID_CLIENT_ID'],
                                  secret: ENV['PLAID_SECRET'],
                                  public_key: ENV['PLAID_PUBLIC_KEY'])
  end

  # Exchanges a Plaid public_token for an access_token
  # @param {String} - Plaid public_token
  # return {Object} - An object with access_token or error
  def exchange_public_token(public_token)
    begin
      response = @client.item.public_token.exchange(public_token)
    rescue Plaid::InvalidInputError => error
      response = { 'error' => { 'message' => error.error_message } }
    end

    response
  end

  # Gets all transactions between two dates via the Plaid API
  # @param {String} access_token - An access_token provided by the Plaid API
  # @param {String} start_date - Transaction query start date formatted YYYY-MM-DD
  # @param {String} end_date - Transaction query start date formatted YYYY-MM-DD
  # return {Object} An object with a list of transactions or an error
  def get_all_transactions(access_token, start_date, end_date)
    begin
      response = @client.transactions.get(access_token, start_date, end_date)
    rescue Plaid::InvalidInputError => error
      response = { 'error' => { 'message' => error.error_message } }
    end

    response
  end
end