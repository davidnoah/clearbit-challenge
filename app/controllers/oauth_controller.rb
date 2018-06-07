require 'plaid'

class OAuthController < ApplicationController
  client = Plaid::Client.new(env: :sandbox,
                             client_id: ENV['PLAID_CLIENT_ID'],
                             secret: ENV['PLAID_SECRET'],
                             public_key: ENV['PLAID_PUBLIC_KEY'])

  get '/access-token' do
    response = client.item.public_token.exchange(params['public_token'])
    response.access_token
  end
end