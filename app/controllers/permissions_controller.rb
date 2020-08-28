class PermissionsController < ApplicationController
  
  def index
    @project = Project.find_by(id: params[:project_id])
    @collaborators = @project.all_collaborators
    @permission = Permission.new
  end

  def create
    @user = User.find_by(email: params[:permission][:user_email])
    if @user
      @permission = Permission.new(permissions_params.except("user_email"))
      @permission.user_id = @user.id
      @permission.save
      redirect_to project_permissions_path(params[:project_id])
    else
      redirect_to project_permissions_path(params[:project_id])
    end
  end

  def edit
   
  end

  def update
    @permission = Permission.find_by(id: params[:id])
    @permission.update(permissions_params)
    redirect_to project_path(@permission.project)
  end

  def destroy
  end

  private

  def permissions_params
    params.require(:permission).permit(:project_id, :user_email, :creator_id, :access_level, :accepted)
  end

end