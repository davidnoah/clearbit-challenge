# config.ru
require 'sinatra/base'
require 'sinatra/cross_origin'
require 'dotenv'
require_relative './app/controllers/application_controller'

Dotenv.load

# pull in the helpers and controllers
Dir.glob('./app/{helpers,controllers}/*.rb').each { |file| require file }

# map the controllers to routes
map('/transactions') { run TransactionController }
map('/oauth') { run OAuthController }
map('/') { run ApplicationController }