require_relative '../clients/plaid_client'
require_relative '../clients/clearbit_client'
require 'active_support/all'

class TransactionsController < ApplicationController
  helpers Sinatra::Param
  helpers ApplicationHelper

  before do
    content_type :json
  end

  get '' do
    param :access_token,
          String,
          required: true,
          message: param_vaidation_error_message('access_token')
    param :start_date,
          String,
          required: true,
          message: param_vaidation_error_message('start_date')
    param :end_date,
          String,
          required: true,
          message: param_vaidation_error_message('end_date')

    params = request.params
    plaid_client = PlaidClient.new

    response = plaid_client.get_all_transactions(params["access_token"], 
                                                 params["start_date"], 
                                                 params["end_date"])
    return response.to_json unless response['transactions']

    transactions = Transaction.process_transactions(response['transactions'])

    transactions.to_json
  end
end