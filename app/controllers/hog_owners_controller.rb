class HogOwnersController < ApplicationController

  before_filter :require_user
  
  def index
  end

  def new
    @hog_owner = HogOwner.new
    # Farms are all unsupplied farms
    @farms = Farm.where("hog_owner_id is null")
    @hog_owner.user_id = params[:user_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hog_owner }
    end
  end

  def create
    @hog_owner = HogOwner.new(params[:hog_owner])

    respond_to do |format|
      if @hog_owner.save
        @hog_owner.user.owner_id = @hog_owner.id
        @hog_owner.user.save   
        
        format.html { redirect_to '/users' }
        format.json { render json: @hog_owner, status: :created, location: @hog_owner }
      else
        format.html { render action: "new" }
        format.json { render json: @hog_owner.errors, status: :unprocessable_entity }
      end
    end
  end


  def edit
    @hog_owner = HogOwner.find(params[:id])
  end

  def update
  end

  def destroy
  end
end
