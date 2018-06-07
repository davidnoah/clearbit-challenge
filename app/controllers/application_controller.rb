class ApplicationController < Sinatra::Base
  configure :production, :development do
    enable :logging
  end
end