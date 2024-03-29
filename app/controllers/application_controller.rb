class ApplicationController < ActionController::Base
  protect_from_forgery

  # filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user
  
  private

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        respond_to do |format|
          format.html { return false }
          format.xml  { head :unauthorized  }
        end
      end
    end

    def default_serializer_options
      {root: false}
    end


    def require_admin
      unless current_user && current_user.is_admin?
        redirect_to '/dashboard'
        respond_to do |format|
          format.html { return false }
          format.xml  { head :unauthorized  }
        end
      end
    end
    
    
    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        # redirect_to users_url
        redirect_to root_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.url
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    
    def set_user_time_zone
      if current_user
        Time.zone = current_user.time_zone
      else
        Time.zone = "UTC"
      end
    end
end
