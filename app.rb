require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/partial'
require 'require_all'

require_relative 'config/environments'

require_all 'models'

get '/' do

	@champs = Champion.home_list

	erb :'pages/home'
end

get '/champions/:key' do

	key = params[:key].downcase

	@champion = Champion.where("lower(key) = ?", key).first

	unless @champion

		# some sort of 404
	end

	erb :'champions/show'
end