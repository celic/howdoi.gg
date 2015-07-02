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

end
