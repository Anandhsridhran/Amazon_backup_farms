class FarmsController < ApplicationController

  before_filter :require_user
  
  # GET /farms
  # GET /farms.json
  def index
    @farms = current_user.farms
    set_page_title

    @barn = []
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @farms }
    end
  end

  def set_page_title
    @page_title = "Farms"
    @header_icon_class = "icon-home"
    @page_subtitle = ""
  end

  # GET /farms/1
  # GET /farms/1.json
  def show
    @farm = Farm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @farm }
    end
  end

  # GET /farms/1/locations
  # GET /farms/1/locations.json
  def locations
    farm = Farm.find(params[:id])

    @locations = []
    # Find which locations this user is authorized to access
    if (current_user.is_hog_owner? || current_user.is_farm_owner? || current_user.is_admin?)
      @locations = farm.locations
    elsif current_user.is_barn_manager?
      @locations << current_user.owner.barn.location
    elsif current_user.is_site_manager?
      @locations << current_user.owner.location
    end

    @page_title = "Sites"
    @header_icon_class = "icon-road"
    @page_subtitle = ""
      
    respond_to do |format|
      format.html { render '/locations/index' }
      format.json { render json: @locations }
    end
  end

  # GET /farms/new
  # GET /farms/new.json
  def new
    @farm = Farm.new
    set_page_title
    @hog_owners = HogOwner.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @farm }
    end
  end

  # GET /farms/1/edit
  def edit
    @farm = Farm.find(params[:id])
    @hog_owners = HogOwner.all
    set_page_title
  end

  # POST /farms
  # POST /farms.json
  def create
    @farm = Farm.new(params[:farm])

    respond_to do |format|
      if @farm.save
        format.html { redirect_to @farm, notice: 'Farm was successfully created.' }
        format.json { render json: @farm, status: :created, location: @farm }
      else
        format.html { render action: "new" }
        format.json { render json: @farm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /farms/1
  # PUT /farms/1.json
  def update
    @farm = Farm.find(params[:id])

    respond_to do |format|
      if @farm.update_attributes(params[:farm])
        format.html { redirect_to @farm, notice: 'Farm was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @farm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /farms/1
  # DELETE /farms/1.json
  def destroy
    @farm = Farm.find(params[:id])
    @farm.destroy

    respond_to do |format|
      format.html { redirect_to farms_url }
      format.json { head :no_content }
    end
  end
end
