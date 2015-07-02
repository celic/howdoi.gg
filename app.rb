require 'sinatra'
require 'sinatra/activerecord'
require 'require_all'

require_relative 'config/environments'

get '/' do
	erb :'pages/home'
end
