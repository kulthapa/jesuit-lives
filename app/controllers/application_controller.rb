class ApplicationController < ActionController::Base
  # Adds a few additional behaviors into the application controller
  include Blacklight::Controller
  layout :determine_layout if respond_to? :layout

  def require_login
    unless current_user
        redirect_to user_session_path
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { render template: "shared/_not_permitted", status: :forbidden, locals: {alert: exception.message} }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

end
