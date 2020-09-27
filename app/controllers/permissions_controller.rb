class PermissionsController < ApplicationController
  before_action :confirm_owner

  def index
    @project = Project.find_by(id: params[:project_id])
    @collaborator_list = @project.collaborators_with_access_level
    @permission = Permission.new
  end

  def create
    @user = User.find_by(email: params[:permission][:user_email])
    @project = Project.find_by(id: params[:project_id])
    if @user && @project.collaborators.exclude?(@user)
      @permission = Permission.new(permissions_params.except("user_email"))
      @permission.user_id = @user.id
      @permission.save
      redirect_to project_permissions_path(params[:project_id])
    elsif @user && @project.collaborators.include?(@user)
      @collaborator_list = @project.collaborators_with_access_level
      @permission = Permission.new
      flash.now[:error] = "#{@user.full_name} is already a collaborator on this project."
      render :index
    else
      @collaborator_list = @project.collaborators_with_access_level
      @permission = Permission.new
      flash.now[:error] = "The email address #{params[:permission][:user_email]} is not currently associated with a Tandem user."
      render :index
    end
  end

  def show
    @permission = Permission.find_by(id: params[:id])
    @project = Project.find_by(id: params[:project_id])
  end

  def edit
    @permission = Permission.find_by(id: params[:id])
    @project = Project.find_by(id: params[:project_id])
    @user = @permission.user
  end

  def update
    @permission = Permission.find_by(id: params[:id])
    @permission.update(permissions_params)
    redirect_to project_path(@permission.project)
  end

  def destroy
    @permission = Permission.find_by(id: params[:id])
    @permission.destroy
    redirect_to project_permissions_path(@permission.project)
  end

  private

  def permissions_params
    params.require(:permission).permit(:project_id, :user_email, :creator_id, :access_level, :accepted)
  end

end