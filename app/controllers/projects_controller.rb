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
  end

  def show
    find_project
    @owners = @project.owners
    @collaborator_list = @project.collaborators_with_access_level
    @collaborators = @project.collaborators
    @sections = Section.where(project_id: @project.id)
    @loose_tasks = @project.tasks.where(section_id: nil)
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

end