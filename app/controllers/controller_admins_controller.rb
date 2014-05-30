class ControllerAdminsController < ApplicationController

  before_filter :require_user
  
  # GET /controller_admins
  # GET /controller_admins.json
  def index
    @controller_admins = ControllerAdmin.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @controller_admins }
    end
  end

  # GET /controller_admins/1
  # GET /controller_admins/1.json
  def show
    @controller_admin = ControllerAdmin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @controller_admin }
    end
  end

  # GET /controller_admins/new
  # GET /controller_admins/new.json
  def new
    set_page_title
    @controller_admin = ControllerAdmin.new
    @controller_admin.barn = barn = Barn.find(params[:barn_id])
    @controller_admin.build_user
    @controller_admin.user.first_name = barn.name
    @controller_admin.user.last_name = 'Controller Admin'
    @controller_admin.user.email = 'controller_admin'+barn.id.to_s+"@amfnano.com"
    @controller_admin.user.username = 'controller_admin_'+barn.id.to_s

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @controller_admin }
    end
  end

  # GET /controller_admins/1/edit
  def edit
    set_page_title
    @controller_admin = ControllerAdmin.find(params[:id])
  end

  def set_page_title
    @page_title = "Controller Admin"
    @header_icon_class = "icon-user"
    @page_subtitle = "Set up a controller administrator for this location"
  end

  # POST /controller_admins
  # POST /controller_admins.json
  def create
    @controller_admin = ControllerAdmin.new(params[:controller_admin])

    respond_to do |format|
      if @controller_admin.save
        format.html { redirect_to barns_path }
        format.json { render json: @controller_admin, status: :created, location: @controller_admin }
      else
        format.html { render action: "new" }
        format.json { render json: @controller_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /controller_admins/1
  # PUT /controller_admins/1.json
  def update
    @controller_admin = ControllerAdmin.find(params[:id])

    respond_to do |format|
      if @controller_admin.update_attributes(params[:controller_admin])
        format.html { redirect_to @controller_admin, notice: 'Controller admin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @controller_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controller_admins/1
  # DELETE /controller_admins/1.json
  def destroy
    @controller_admin = ControllerAdmin.find(params[:id])
    @controller_admin.destroy

    respond_to do |format|
      format.html { redirect_to controller_admins_url }
      format.json { head :no_content }
    end
  end
end
