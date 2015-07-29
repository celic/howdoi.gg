# == Schema Information
#
# Table name: builds
#
#  id              :integer          not null, primary key
#  champion_id     :integer
#  role            :integer
#  items           :integer          default([]), is an Array
#  summoner_spells :integer          default([]), is an Array
#

class Build < ActiveRecord::Base


    # Member functions
    def role_to_string
        if role == 1
            "top"
        elsif role == 2 
            "mid"
        elsif role == 3
            "jungle"
        elsif role == 4
            "adc"
        elsif role == 5
            "support"
        end
        "unknown"
    end
end 
