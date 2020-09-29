class ApplicationController < ActionController::Base
  add_flash_types :error, :errors, :success

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
    set_project
    unless @project.owners.include?(current_user)
      flash[:error] = "You must be a project owner to take this action."
      redirect_to project_path(@project)
    end
  end

  def confirm_manager_or_owner
    set_project
    unless @project.managers_plus.include?(current_user)
      flash[:error] = "You must have Manager-level access or higher to take this action."
      redirect_to project_path(@project)
    end
  end

  private

  def set_project
    if params[:project_id]
      @project = Project.find_by(id: params[:project_id])
    elsif params[:assignment]
      task = Task.find_by(id: params[:assignment][:task_id])
      @project = task.project
    else
      @project = Project.find_by(id: params[:id])
    end
  end


end
