class EntriesController < ApplicationController
  def index
  	@entries = Entry.all
    @shower_time = @entries.group_by {|e| e.created_at.day}.values.map{ |a| [a.first.created_at.midnight.to_i * 1000, (a.sum(&:shared_lightbulbs) / a.count)] }
    @plugged_in = @entries.group_by {|e| e.created_at.day}.values.map{ |a| [a.first.created_at.midnight.to_i * 1000, (a.sum(&:plugged_in) / a.count)] }
  end

  def new
  	@user = User.find(params[:id]) rescue nil
    current_time = Time.now.in_time_zone("Eastern Time (US & Canada)")
  	hour = current_time.hour
  	@can_enter = (hour >= 18 && hour <= 24) || (!params[:test].nil? && params[:test] = true)
    if @user
      @can_enter = false if @user.entries.last.created_at.day == current_time.day
    end
  	if @user && @can_enter
  		@entry = Entry.new
  	end
  end

  def create
  	@entry = Entry.new(params[:entry])
  	user = @entry.user
  	@entry.room = user.room
  	@entry.floor = user.floor

  	if @entry.save
  		redirect_to entries_path
  	else
  		render 'new'
  	end

  end


end
