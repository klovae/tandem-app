class TasksController < ApplicationController

  def index
    #needs to work on its own and with a nested route
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

  def show

  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def task_params
    params.require(:task).permit(:content, :deadline, :project_id, :parent_id)
  end
end