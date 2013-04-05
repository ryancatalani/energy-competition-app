class User < ActiveRecord::Base
  attr_accessible :email, :floor, :name, :phone, :room
  has_many :entries
end
