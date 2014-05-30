class UserSession < Authlogic::Session::Base
  single_access_allowed_request_types :any
  logout_on_timeout false
  find_by_login_method :find_by_username_or_email
  generalize_credentials_error_messages "Username/password is invalid"

  def to_key
     new_record? ? nil : [ self.send(self.class.primary_key) ]
  end

  def persisted?
    false
  end

end
