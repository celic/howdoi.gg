require 'sinatra/activerecord'

# Disable database logging
old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

# Require all pullers
require_relative 'pullers/current_patch'
require_relative 'pullers/current_champions'
require_relative 'pullers/current_items'

# Re-enable database logging
ActiveRecord::Base.logger = old_logger