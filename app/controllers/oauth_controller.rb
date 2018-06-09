require_relative '../clients/plaid_client'

class OAuthController < ApplicationController
  helpers Sinatra::Param
  helpers ApplicationHelper

  before do
    content_type :json
  end

  post '/access-token' do
    param :public_token,
          String,
          required: true,
          message: param_vaidation_error_message('public_token')

    plaid_client = PlaidClient.new
    response = plaid_client.exchange_public_token(request.params['public_token'])

    halt 500, response[:error].to_json if response[:error]

    { :access_token => response.access_token }.to_json
  end
end