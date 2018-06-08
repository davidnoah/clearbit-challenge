require_relative '../clients/plaid_client'
require_relative '../clients/clearbit_client'

class TransactionsController < ApplicationController
  get '/' do
    params = request.params
    plaid_client = PlaidClient.new

    response = plaid_client.get_all_transactions(params["access_token"], 
                                                 params["start_date"], 
                                                 params["end_date"])
    return response.to_json unless response['transactions']

    transactions = Transaction.process_transactions(response['transactions'])
    p transactions
    response.to_json
  end
end