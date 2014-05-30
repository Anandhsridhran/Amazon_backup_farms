class BarnsController < ApplicationController

  before_filter :require_user

  # GET /barns
  # GET /barns.json
  def index
    @barns = current_user.barns

    set_page_title

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @barns }
    end
  end

  # GET /barns/1
  # GET /barns/1.json
  def show
    @barn = Barn.find(params[:id])
    @page_title = @barn.name
    @header_icon_class = "icon-building"
    @reading = @last_reading =  @barn.readings.any? ? @barn.readings.last : nil
    @readings = []
    if @last_reading
      first_reading_time = @last_reading.created_at - 5.days
      @readings = Reading.where("barn_id = ? and created_at > ? and created_at <= ?",
        @barn.id, first_reading_time, @last_reading.created_at).order("created_at DESC")
    end
    @event_reports = @barn.event_reports.order("created_at DESC")
    
    @inventory_report = @barn.inventory_reports.last
    @shipment = @barn.shipments.last
    @total_pigs = @barn.total_pigs
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @barn }
    end
  end

  # GET /barns/1/last_reading
  # GET /barns/1/last_reading.json
  def last_reading
    barn = Barn.find(params[:id])
    @reading = barn.readings.last rescue nil

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reading}
    end
  end

  # GET /barns/1/last_shipment
  # GET /barns/1/last_shipment.json
  def last_shipment
    barn = Barn.find(params[:id])
    @shipment = barn.shipments.last rescue nil

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shipment}
    end
  end

  # GET /barns/1/last_event_report
  # GET /barns/1/last_event_report.json
  def last_event_report
    barn = Barn.find(params[:id])
    @event_report = barn.event_reports.last rescue nil

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event_report}
    end
  end

  # GET /barns/1/last_inventory_report
  # GET /barns/1/last_inventory_report.json
  def last_inventory_report
    barn = Barn.find(params[:id])
    @inventory_report = barn.inventory_reports.last rescue nil

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory_report}
    end
  end

  def update_locations
    # Updates locations and barns based on farm selected
    farm = Farm.find(params[:farm_id])
    # map to name and ID for use in our options_for_select
    @locations = farm.locations.map{|loc| [loc.name, loc.id]}.insert(0, "Select a site")
    @barns = farm.barns.map{|barn| [barn.name, barn.id]}.insert(0, "Select a barn")
  end

  def update_barns
    # Updates barns  based on location selected
    location = Location.find(params[:location_id])
    # map to name and ID for use in our options_for_select
    @barns = location.barns.map{|barn| [barn.name, barn.id]}.insert(0, "Select a barn")
  end


  # GET /barns/new
  # GET /barns/new.json
  def new
    @barn = Barn.new
    set_page_title
    if current_user.is_admin?
      @farms = Farm.all
      @locations = []
      @barns = []
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @barn }
    end
  end

  # GET /barns/1/edit
  def edit
    @barn = Barn.find(params[:id])
    set_page_title
  end

  def set_page_title
    @page_title = "Barns"
    @header_icon_class = "icon-building"
    @page_subtitle = ""
  end

  # POST /barns
  # POST /barns.json
  def create
    @barn = Barn.new(params[:barn])

    respond_to do |format|
      if @barn.save
        BarnConfiguration.create_default(@barn)
        format.html { redirect_to '/barns/'+@barn.id.to_s+'/controller_admins/new' }
        format.json { render json: @barn, status: :created, location: @barn }
      else
        format.html { render action: "new" }
        format.json { render json: @barn.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /barns/1
  # PUT /barns/1.json
  def update
    @barn = Barn.find(params[:id])

    respond_to do |format|
      if @barn.update_attributes(params[:barn])
        if @barn.controller_admin
          redirect_path = '/barns/'+@barn.id.to_s+'/controller_admins/'+@barn.controller_admin.id.to_s+'/edit'
        else
          redirect_path = '/barns/'+@barn.id.to_s+'/controller_admins/new'
        end
        format.html { redirect_to redirect_path }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @barn.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /barns/1
  # DELETE /barns/1.json
  def destroy
    @barn = Barn.find(params[:id])
    @barn.destroy

    respond_to do |format|
      format.html { redirect_to barns_url }
      format.json { head :no_content }
    end
  end
end
