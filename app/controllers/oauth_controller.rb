require 'plaid'
require 'json'

class OAuthController < ApplicationController
  client = Plaid::Client.new(env: :sandbox,
                             client_id: ENV['PLAID_CLIENT_ID'],
                             secret: ENV['PLAID_SECRET'],
                             public_key: ENV['PLAID_PUBLIC_KEY'])

  post '/access-token' do
    request.body.rewind
    data = JSON.parse request.body.read
    response = client.item.public_token.exchange(data['public_token'])
    response.access_token
  end
end