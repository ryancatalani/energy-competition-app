class Entry < ActiveRecord::Base
  attr_accessible :floor, :personal_lightbulbs, :plugged_in, :recycled_items, :room, :shared_lightbulbs, :shower_time, :user_id
  belongs_to :user
end
