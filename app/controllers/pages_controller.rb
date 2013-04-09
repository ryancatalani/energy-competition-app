class PagesController < ApplicationController
  def index
  	@body_class = "index"

  	begin

	  	prow = Entry.where(:floor => 0).group_by {|e| e.created_at.day}.values.sort
	  	lb = Entry.where(:floor => 1).group_by {|e| e.created_at.day}.values.sort

	  	avg_lightbulb_wattage = 30
	  	avg_device_wattage = 80
	  	avg_shower_wattage = 20000
	  	avg_roommates = 3.5
	  	avg_hours_lights_on = 5.9 # Assuming an daily average (over a week) of 7 hours of sleep, 2.2 hours of class, and spending half the time of the room.
	  	avg_hours_devices_in = 19 # Most devices stay plugged in (or not plugged in)

	  	@wattage = {}
	  	@recycled_items = {}

	  	# *1000 for Javascript
	  	@recycled_items[:prow] = prow.map{ |a| [a.first.created_at.midnight.to_i * 1000, (a.sum(&:recycled_items) / a.count)] }
	  	@recycled_items[:prow_latest] = @recycled_items[:prow].last[1]

	  	@recycled_items[:lb] = lb.map{ |a| [a.first.created_at.midnight.to_i * 1000, (a.sum(&:recycled_items) / a.count)] }
	  	@recycled_items[:lb_latest] = @recycled_items[:lb].last[1]

	  	@wattage[:prow] = prow.map do |day_entries|
	  		avg_shower_time = day_entries.sum(&:shower_time) / day_entries.count # In minutes
	  		this_avg_shower_wh = (avg_shower_time / 60) * avg_shower_wattage

	  		avg_devices = day_entries.sum(&:plugged_in) / day_entries.count
	  		this_avg_devices_wh = avg_devices * avg_device_wattage * avg_hours_devices_in

	  		avg_personal_lights = day_entries.sum(&:personal_lightbulbs) / day_entries.count
	  		this_avg_personal_light_wh = avg_personal_lights * avg_lightbulb_wattage * avg_hours_lights_on

	  		rooms = day_entries.group_by{|e| e.room}.values.map {|r| r.sum(&:shared_lightbulbs) / r.count }
	  		avg_shared_lights = rooms.reduce(:+) / rooms.count
	  		this_avg_shared_lights_wh = (avg_shared_lights / avg_roommates) * avg_lightbulb_wattage * avg_hours_lights_on

	  		sum_wh = this_avg_shower_wh + this_avg_devices_wh + this_avg_personal_light_wh + this_avg_shared_lights_wh
	  		sum_kwh = sum_wh / 1000.0

	  		[day_entries.first.created_at.midnight.to_i * 1000, sum_kwh]
	  	end

	  	@wattage[:lb] = lb.map do |day_entries|
	  		avg_shower_time = day_entries.sum(&:shower_time) / day_entries.count # In minutes
	  		this_avg_shower_wh = (avg_shower_time / 60) * avg_shower_wattage

	  		avg_devices = day_entries.sum(&:plugged_in) / day_entries.count
	  		this_avg_devices_wh = avg_devices * avg_device_wattage * avg_hours_devices_in

	  		avg_personal_lights = day_entries.sum(&:personal_lightbulbs) / day_entries.count
	  		this_avg_personal_light_wh = avg_personal_lights * avg_lightbulb_wattage * avg_hours_lights_on

	  		rooms = day_entries.group_by{|e| e.room}.values.map {|r| r.sum(&:shared_lightbulbs) / r.count }
	  		avg_shared_lights = rooms.reduce(:+) / rooms.count
	  		this_avg_shared_lights_wh = (avg_shared_lights / avg_roommates) * avg_lightbulb_wattage * avg_hours_lights_on

	  		sum_wh = this_avg_shower_wh + this_avg_devices_wh + this_avg_personal_light_wh + this_avg_shared_lights_wh
	  		sum_kwh = sum_wh / 1000.0

	  		[day_entries.first.created_at.midnight.to_i * 1000, sum_kwh]
	  	end

	  	@wattage[:prow_latest] = @wattage[:prow].last[1]
	  	@wattage[:lb_latest] = @wattage[:lb].last[1]

	  rescue

	  	@data_not_ready = true

	  end

  end
end
