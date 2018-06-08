require_relative '../clients/plaid_client'

class TransactionsController < ApplicationController
  get '/' do
    params = request.params
    plaid_client = PlaidClient.new
    response = plaid_client.get_all_transactions(params["access_token"], 
                                                 params["start_date"], 
                                                 params["end_date"])

    return response if response.status_code >= 400

    response.to_json
  end
end