class ApplicationController < ActionController::Base
  include CurrentCart
  before_action :find_cart
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
      if current_user.has_role?(:admin)
        dashboard_path
      else
        root_path
      end
  end
end
