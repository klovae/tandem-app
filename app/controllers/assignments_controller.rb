class AssignmentsController < ApplicationController

  def create
    @assignment = Assignment.create(assignment_params)
    redirect_to project_path(@assignment.task.project)
  end

  private

  def assignment_params
    params.require(:assignment).permit(:user_id, :task_id)
  end


end


