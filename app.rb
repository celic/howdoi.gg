require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/partial'
require 'require_all'
require 'json'

require_relative 'config/environments'

require_all 'models'

before do
	headers 'Access-Control-Allow-Origin' => 'http://localhost:9000'
	headers 'Access-Control-Allow-Headers' => 'Origin, X-Requested-With, Content-Type, Accept'

	if request.request_method == 'OPTIONS'
		headers 'Access-Control-Allow-Methods' => 'GET'

		halt 200
	end
end

get '/' do

	@champs = Champion.home_list

	erb :'pages/home'
end

get '/champions/:key' do

	key = params[:key].downcase

	@champion = Champion.where("lower(key) = ?", key).first

	unless @champion

		erb :'pages/404'
	end

	erb :'champions/show'
end

get '/api/champions/:id/?' do
    content_type :json 
    
    #role = default
    role = params[:role] unless params[:role].nil?
    
    build = Build.find_by champion: id, role: role 
    
    build.to_json
end 

get 'api/champions/list/?' do
    content_type :json 
    
    search = params[:search] 
    
    if search.nil?
        Champion.all.to_json
    else 
        Champion.find_by(name: search).to_json
    end 
end