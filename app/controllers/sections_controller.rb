class SectionsController < ApplicationController
  before_action :confirm_manager_or_owner

  def index
    @new_section = Section.new
    @project = Project.find_by(id: params[:project_id])
    @sections = @project.sections
  end


  def new
    @section = Section.new
    @project = Project.find_by(id: params[:project_id])
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      redirect_to project_path(@section.project)
    else
      @project = Project.find_by(id: params[:project_id])
      flash.now[:error] = "Sections need a name."
      render :new
    end
  end

  def update
    @section = Section.find_by(id: params[:id])
    @project = Project.find_by(id: params[:project_id])
    if @section.update(section_params)
      flash[:success] = "Section name updated."
      redirect_to project_path(@project)
    else
      @sections = @project.sections
      flash.now[:error] = "Sections need a name."
      render :index
    end
  end

  private

  def section_params
    params.require(:section).permit(:name, :project_id)
  end

end