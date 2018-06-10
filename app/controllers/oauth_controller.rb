require_relative '../clients/plaid_client'

class OAuthController < ApplicationController
  helpers Sinatra::Param
  helpers ApplicationHelper

  before do
    content_type :json
  end

  # Exchanges a public_token for an access_token throuh the Plaid API
  # @param {String} public_token - Token provided by the Plaid API after loging in to your bank account
  # return {Object} - A json object with an access_token
  post '/access-token' do
    param :public_token,
          String,
          required: true,
          message: param_vaidation_error_message('public_token')

    plaid_client = PlaidClient.new
    response = plaid_client.exchange_public_token(request.params['public_token'])

    halt 500, response['error'].to_json if response['error']

    { :access_token => response.access_token }.to_json
  end
end