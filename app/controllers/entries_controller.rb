class EntriesController < ApplicationController
  def index
  end

  def new
  	@user = User.find(params[:id]) rescue nil
  	hour = Time.now.in_time_zone("Eastern Time (US & Canada)").hour
  	@can_enter = (hour >= 18 && hour <= 24) || Rails.env.development?
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
