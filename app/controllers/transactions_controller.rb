require_relative '../clients/plaid_client'
require_relative '../clients/clearbit_client'
require 'active_support/all'

class TransactionsController < ApplicationController
  helpers Sinatra::Param
  helpers ApplicationHelper

  before do
    content_type :json
  end

  # Returns a list of transactions processed through the Clearbit API and
  # assessed for recurring payments
  # @param {String} access_token - An access_token provided by the Plaid API
  # @param {String} start_date - Transaction query start date formatted YYYY-MM-DD
  # @param {String} end_date - Transaction query start date formatted YYYY-MM-DD
  # return {Array} - A json array with a list of transaction objects
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
    halt 500, response[:error].to_json if response[:error]

    transactions = Transaction.process_transactions(response['transactions'])

    transactions.to_json
  end
end