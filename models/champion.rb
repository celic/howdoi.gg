# == Schema Information
#
# Table name: champions
#
#  id         :integer          not null, primary key
#  riot_id    :string
#  name       :string
#  desc       :string
#  created_at :datetime
#  updated_at :datetime
#  key        :string
#  free       :boolean
#

class Champion < ActiveRecord::Base

    # Member functions
    def as_json
        json = {
            id: id, 
            riot_id: riot_id,
            name: name,
            desc: desc,
            key: key,
            free: free
        }
    end 

	# Class functions
	def self.free_list
		Champion.all.where 'free is true'
	end

	def self.home_list
		Champion.all.order('free desc, name asc').map { |c| c.key }
	end
end
