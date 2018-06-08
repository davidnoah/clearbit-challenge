require_relative '../clients/plaid_client'

class OAuthController < ApplicationController
  post '/access-token' do
    plaid_client = PlaidClient.new
    response = plaid_client.exchange_public_token(request.params['public_token'])

    { :access_token => response.access_token }.to_json
  end
end