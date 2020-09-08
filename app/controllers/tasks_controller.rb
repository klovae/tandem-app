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
    @task = Task.new
    @project = Project.find_by_id(params[:project_id])
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = "Task created."
      redirect_to project_path(@task.project)
    else
      flash[:errors] = @task.errors.full_messages
      render :new
    end
  end

  def edit
    set_task
    @project = @task.project
  end

  def update
    set_task
    if @task.update(task_params)
      flash[:success] = "Task updated."
      redirect_to project_path(@task.project)
    else
      flash[:errors] = @task.errors.full_messages
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
    params.require(:task).permit(:content, :deadline, :project_id, :section_id, :parent_id, :status)
  end
end