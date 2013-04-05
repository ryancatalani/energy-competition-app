class ApplicationController < ActionController::Base
  protect_from_forgery

  def competition_floors
  	["Piano Row, floor 3", "Little Building, floor 5"]
  end

  def competition_floors_arr
  	competition_floors.each_with_index.map {|x,i| [x, i] }
  end

  def competition_floor_from(index)
  	competition_floors[index] rescue ""
  end

  helper_method :competition_floors_arr, :competition_floor_from

end
