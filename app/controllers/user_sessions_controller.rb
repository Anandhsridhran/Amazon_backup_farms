class UserSessionsController < ApplicationController
  # before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  # We want the iPhone app to be able to login, so we skip the normal
  # authenticity check.
  skip_before_filter :verify_authenticity_token

  def new
    reset_session
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])

    respond_to do |format|
      if @user_session.save
        current_user = @user_session.user if !current_user
        current_user.reset_single_access_token!
        format.html { redirect_to :controller => "dashboard", :action => "index" }
        format.json { render :json => current_user }
      else
        format.html { render :action => 'new' }
        format.to_json { render :json => @user_session.errors, :status => :unauthorized }
      end
    end
  end

  def destroy
    @user_session = UserSession.find
    current_user.reset_single_access_token! unless current_user.nil?
    @user_session.destroy

    respond_to do |format|
      format.html { redirect_to(:users) }
      format.xml { head :ok }
    end
  end
end
