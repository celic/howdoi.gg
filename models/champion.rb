# == Schema Information
#
# Table name: champions
#
#  id         :integer          not null, primary key
#  riot_id    :integer
#  name       :string
#  desc       :string
#  created_at :datetime
#  updated_at :datetime
#

class Champion < ActiveRecord::Base

	# Class functions
	def self.free_list
		Champion.all.where 'free is true'
	end

	def self.home_list
		Champion.all.order('free desc, name asc').map { |c| c.key }
	end
end
