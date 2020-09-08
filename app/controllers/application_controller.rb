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

  def confirm_owner
    if params[:project_id]
      @project = Project.find_by(id: params[:project_id])
    else
      @project = Project.find_by(id: params[:id])
    end
    unless @project.owners.include?(current_user)
      flash[:errors] = "You must be a project owner to make changes to the project details"
      redirect_to project_path(@project)
    end
  end

end
