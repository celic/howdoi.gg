configure :development, :production do
	
	db = YAML.load(ERB.new(File.read(File.join("config","database.yml"))).result)
	ActiveRecord::Base.establish_connection(db[settings.environment.to_s])

	set :api_key, db['api']['key']

	set :partial_template_engine, :erb
	enable :partial_underscores
end