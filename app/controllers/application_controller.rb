class ApplicationController < ActionController::Base
  add_flash_types :error
  add_flash_types :success

  helper_method :current_user
  before_action :auth_required

  def current_user
    User.find_by_id(session[:user_id])
  end

  def auth_required
    unless current_user
        redirect_to login_path
    end
  end

end
