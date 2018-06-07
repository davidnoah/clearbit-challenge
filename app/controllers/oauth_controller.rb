class OAuthController < ApplicationController
  get '/request-token' do
    'Request token!'
  end

  get '/access-token' do
    'Access token!'
  end
end