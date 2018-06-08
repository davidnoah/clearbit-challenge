# config.ru
require 'sinatra/base'
require 'sinatra/cross_origin'
require 'json'

require 'dotenv'

Dotenv.load

# pull in the helpers and controllers
Dir.glob('./app/{helpers,controllers,models}/*.rb').each { |file| require file }

# map the controllers to routes
map('/') { run ApplicationController }
map('/oauth') { run OAuthController }
map('/transactions') { run TransactionsController }