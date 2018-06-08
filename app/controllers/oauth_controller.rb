require 'plaid'

class OAuthController < ApplicationController
  client = Plaid::Client.new(env: :sandbox,
                             client_id: ENV['PLAID_CLIENT_ID'],
                             secret: ENV['PLAID_SECRET'],
                             public_key: ENV['PLAID_PUBLIC_KEY'])

  post '/access-token' do
    content_type :json
    response = client.item.public_token.exchange(request.params['public_token'])

    { :access_token => response.access_token }.to_json
  end
end