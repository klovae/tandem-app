class TasksController < ApplicationController
  before_action :confirm_owner, only: [:destroy]
  
  def index
    #needs to work on its own and with a nested route
    if params[:project_id]
    else
      @tasks = Assignment.user_list(current_user)
    end
  end
  
  def new
    @task = Task.new do |t|
      if params[:section_id]
        @section = Section.find_by(id: params[:section_id])
        t.section_id = params[:section_id]
      end
      t.build_assignment
    end
    @project = Project.find_by(id: params[:project_id])
    @collaborators = @project.collaborators
  end

  def create
    @project = Project.find_by(id: params[:task][:project_id])
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = "Task created."
      redirect_to project_path(@task.project)
    else
      #includes assignment options if no assignment was submitted
      @task.assignment = Assignment.new
      @collaborators = @project.collaborators
      flash.now[:errors] = @task.errors.full_messages
      render :new
    end
  end

  def edit
    set_task
    if @task.assignment.nil?
      @task.build_assignment
    end
    @project = @task.project
    @collaborators = @project.collaborators
  end

  def update
    set_task
    if @task.update(task_params)
      #addresses ability to remove an existing assignment via edit
      if @task.assignment && params[:task][:assignment_attributes][:user_id].blank?
        @task.assignment.destroy
      end
      flash[:success] = "Task updated."
      redirect_to project_path(@task.project)
    else
      flash.now[:errors] = @task.errors.full_messages
      render :edit
    end
  end

  def destroy
    set_task
    @project = @task.project
    @task.destroy
    redirect_to project_path(@project)
  end

  private

  def set_task
    @task = Task.find_by_id(params[:id])
  end

  def task_params
    params.require(:task).permit(:content, :deadline, :project_id, :section_id, :parent_id, :status, assignment_attributes: [:user_id, :id])
  end
end