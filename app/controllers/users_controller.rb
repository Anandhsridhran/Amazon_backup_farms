class UsersController < ApplicationController

  before_filter :require_user

  # GET /users
  # GET /users.json
  def index
    set_page_title

    if current_user.is_admin?
      @users = User.where("owner_type != ?", "Admin").order(:first_name)
    else
      @users = current_user.farm.users.order(:first_name)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    set_page_title
    @user = User.find(params[:id])
    @managed_objects = @user.managed_objects

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/farms
  # GET /users/1/farms.json
  def farms
    user = User.find(params[:id])

    @farms = []
    # Find which farms this user is authorized to access
    if (user.is_hog_owner?)
      @farms = user.owner.farms
    elsif user.is_barn_manager?
      @farms << user.owner.barn.location.farm
    elsif user.is_site_manager?
      @farms << user.owner.location.farm
    elsif user.is_farm_owner?
      @farms << user.owner.farm
    elsif user.is_admin?
      @farms = Farm.all
    end
      
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @farms }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    set_page_title
    if current_user.is_admin?
      @farms = Farm.all
    else
      @user.farm = current_user.farm
    end
    @user.owner_type = "FarmOwner"
    @user.email_alerts_enabled = true
    @objects = Farm.all 
    @id = Farm.first.id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    set_page_title
    @user = User.find(params[:id])
    if !current_user.is_admin? && @user != current_user
      redirect_to "/users"
      return
    end
    if @user.is_farm_owner?
      @objects = Farm.all
      @id = @user.owner.farm.id
    elsif @user.is_site_manager?
      @objects = Location.all
      @id = @user.owner.location.id
    else
      @objects = Barn.all
      @id = @user.owner.barn.id
    end
  end

  def role_changed
    # Updates list of farms, locations or barns based on change of role selector 
    role = params[:role]
    if (role == "FarmOwner")
      objects = Farm.all
    elsif (role == "SiteManager")
      objects = Location.all
    elsif (role == "HogOwner")
      objects = []
    else
      objects = Barn.all
    end
    # map to name and ID for use in our options_for_select
    @managed_objects = objects.map{|obj| [obj.name, obj.id] }  
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    owner = @user.build_owner(params[:managed_object_id]) 

    respond_to do |format|
      if @user.save
        owner.user = @user
        owner.save
        @user.owner = owner
        @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_page_title
    @page_title = "Users"
    @header_icon_class = "icon-user"
    @page_subtitle = ""
  end


  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    set_managed_object(params[:managed_object_id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_managed_object(object_id)
    if @user.is_farm_owner? 
      @user.owner.farm_id = object_id
    elsif @user.is_site_manager?
      @user.owner.location_id = object_id
    elsif @user.is_barn_manager?
      @user.owner.barn_id = object_id
    end
    @user.owner.save
  end
      

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
