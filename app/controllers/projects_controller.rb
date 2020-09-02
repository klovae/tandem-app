class ProjectsController < ApplicationController
  before_action :confirm_owner, only: [:edit, :update, :destroy]

  def index
    @user_projects = current_user.user_projects
  end
  
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      @project.set_owner(current_user)
      redirect_to project_path(@project)
    else
      flash.now[:errors] = @project.errors.full_messages
      redirect :new
    end
    #needs to create the project
    #needs to create permissions and associate them with the project
    #is permissions nested within projects? yes, when looking at a specific project's permissions, but would look at regular index to see all permissions
  end

  def show
    find_project
    @owners = @project.owners
    @collaborator_list = @project.collaborators_with_access_level
    @collaborators = @project.collaborators
    @tasks = @project.tasks
    @assignment = Assignment.new
  end

  def edit
    find_project
  end

  def update
    find_project
    if @project.update(project_params)
      redirect_to project_path(@project)
    else
      flash.now[:errors] = @project.errors.full_messages
      render :edit
    end
  end

  def destroy
    find_project

  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :deadline)
  end

  def find_project
    @project = Project.find_by_id(params[:id])
  end

  def confirm_owner
    find_project
    unless @project.owners.include?(current_user)
      flash[:errors] = "You must be a project owner to make changes to the project details"
      redirect_to project_path(@project)
    end
  end

end