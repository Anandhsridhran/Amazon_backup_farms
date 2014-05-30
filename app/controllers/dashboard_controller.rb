class DashboardController < ApplicationController

	before_filter :require_user
	
  def index
  	@header_icon_class = "icon-dashboard"
  	@page_title = "Dashboard"

    if params[:farm_id] 
      farm = Farm.find(params[:farm_id])
      @barns = farm.barns
      @event_reports = farm.event_reports.order("created_at DESC")
      @subtitle = farm.name
  	elsif !current_user.is_hog_owner? && !current_user.is_admin?
  		@subtitle = current_user.farm.name
  		@barns = current_user.barns
  		@event_reports = current_user.event_reports.order("created_at DESC")
  	else
  		@subtitle = ""
  		@farms = current_user.farms
  	end
  end

end
