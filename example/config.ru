require 'bundler/setup'
require 'sinatra/base'
require 'omniauth-netflix'

class App < Sinatra::Base
  get '/' do
    redirect '/auth/netflix'
  end

  get '/auth/:provider/callback' do
    content_type 'application/json'
    MultiJson.encode(request.env)
  end

  get '/auth/failure' do
    content_type 'application/json'
    MultiJson.encode(request.env)
  end
end

use Rack::Session::Cookie

use OmniAuth::Builder do
  provider :netflix, ENV['APP_ID'], ENV['APP_SECRET']
end

run App.new