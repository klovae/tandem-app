class PermissionsController < ApplicationController
  
  def index
    @project = Project.find_by_id(params[:id])
    @collaborators = @project.all_collaborators
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

end