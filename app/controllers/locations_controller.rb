class LocationsController < ApplicationController
  
  before_filter :require_user

  # GET /locations
  # GET /locations.json
  def index
    @locations = current_user.locations
    
    set_page_title

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])
    @page_title = @location.name
    @header_icon_class = "icon-building"

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end


  # GET /locations/1/barns
  # GET /locations/1/barns.json
  def barns
    location = Location.find(params[:id])
    @barns = []
    if (current_user.is_barn_manager?)
      @barns << current_user.owner.barn
    else
      @barns = location.barns
    end

    @page_title = "Barns"
    @header_icon_class = "icon-building"
    @page_subtitle = ""

    respond_to do |format|
      format.html { render 'barns/index'}
      format.json { render json: @barns }
    end
    
  end


  def set_page_title
    @page_title = "Sites"
    @header_icon_class = "icon-road"
    @page_subtitle = ""
  end

  # GET /locations/new
  # GET /locations/new.json
  def new
    @location = Location.new
    set_page_title
    if current_user.is_admin?
      @farms = Farm.all
    else
      @location.farm = current_user.farm
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
    set_page_title
    if current_user.is_admin? || current_user.is_hog_owner?
      @farms = current_user.farms
    else
      @location.farm = current_user.farm
    end
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(params[:location])

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render json: @location, status: :created, location: @location }
      else
        format.html { render action: "new" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end
end
