require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/partial'
require 'require_all'

require_relative 'config/environments'

require_all 'models'

get '/' do
	erb :'pages/home'
end
