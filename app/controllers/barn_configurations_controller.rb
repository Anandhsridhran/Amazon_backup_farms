class BarnConfigurationsController < ApplicationController

  before_filter :require_user
  
  # GET /barn_configurations
  # GET /barn_configurations.json
  def index
    @barn_configurations = BarnConfiguration.all
    set_page_title

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @barn_configurations }
    end
  end

  def set_page_title
    @page_title = @barn_configuration.barn.name
    @header_icon_class = "icon-cog"
  end

  # GET /barn_configurations/1
  # GET /barn_configurations/1.json
  def show
    if (params[:barn_id])
      @barn = Barn.find(params[:barn_id])
      @bc = @barn_configuration = @barn.barn_configuration
      if params[:updated_at]
        @last_updated_time = LastUpdatedTime.new
        @last_updated_time.updated_at = @bc.updated_at
      end
    else
      @bc = @barn_configuration = BarnConfiguration.find(params[:id])
    end
    set_page_title

    respond_to do |format|
      format.html # show.html.erb
      format.json { 
        if params[:updated_at]
          render json: @last_updated_time
        else
          render json: @barn_configuration 
        end
      }
    end
  end

  # GET /barn_configurations/new
  # GET /barn_configurations/new.json
  def new
    @barn_configuration = BarnConfiguration.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @barn_configuration }
    end
  end

  # GET /barn_configurations/1/edit
  def edit
    if (params[:barn_id])
      @barn = Barn.find(params[:barn_id])
      @barn_configuration = @barn.barn_configuration
    else
      @barn_configuration = BarnConfiguration.find(params[:id])
    end
    set_page_title
  end

  # POST /barn_configurations
  # POST /barn_configurations.json
  def create
    @barn_configuration = BarnConfiguration.new(params[:barn_configuration])

    respond_to do |format|
      if @barn_configuration.save
        format.html { redirect_to @barn_configuration, notice: 'Barn configuration was successfully created.' }
        format.json { render json: @barn_configuration, status: :created, barn: @barn_configuration }
      else
        format.html { render action: "new" }
        format.json { render json: @barn_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /barn_configurations/1
  # PUT /barn_configurations/1.json
  def update
    if (params[:barn_id])
      @barn = Barn.find(params[:barn_id])
      @bc = @barn_configuration = @barn.barn_configuration
    else
      @bc = @barn_configuration = BarnConfiguration.find(params[:id])
    end
    set_page_title
    @bc.updated_at = Time.now.utc

    respond_to do |format|
      if @barn_configuration.update_attributes(params[:barn_configuration])
        format.html { redirect_to @barn_configuration, notice: 'Barn configuration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @barn_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /barn_configurations/1
  # DELETE /barn_configurations/1.json
  def destroy
    @barn_configuration = BarnConfiguration.find(params[:id])
    @barn_configuration.destroy

    respond_to do |format|
      format.html { redirect_to barn_configurations_url }
      format.json { head :no_content }
    end
  end
end
