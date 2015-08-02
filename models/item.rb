# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  riot_id    :string
#  name       :string
#  desc       :string
#  created_at :datetime
#  updated_at :datetime
#  gold_value :integer          default(0)
#

class Item < ActiveRecord::Base

end
