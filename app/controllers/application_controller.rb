class ApplicationController < ActionController::Base
  protect_from_forgery

  def title
    @title.nil? ? "#ECunplugged" : "#{t} | #ECunplugged"
  end

  def body_class
    "class='#{@body_class}'".html_safe unless @body_class.nil?
  end

  def competition_floors
  	["Piano Row, floor 3", "Little Building, floor 5"]
  end

  def competition_floors_arr
  	competition_floors.each_with_index.map {|x,i| [x, i] }
  end

  def competition_floor_from(index)
  	competition_floors[index] rescue ""
  end

  helper_method :title, :body_class, :competition_floors_arr, :competition_floor_from

end
