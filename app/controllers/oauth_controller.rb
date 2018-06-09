require_relative '../clients/plaid_client'

class OAuthController < ApplicationController
  post '/access-token' do
    param :access_token,
          String,
          required: true,
          message: param_vaidation_error_message('public_token')

    plaid_client = PlaidClient.new
    response = plaid_client.exchange_public_token(request.params['public_token'])

    { :access_token => response.access_token }.to_json
  end
end