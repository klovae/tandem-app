class SectionsController < ApplicationController

  def new
    @section = Section.new
    @project = Project.find_by(id: params[:project_id])
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      redirect_to project_path(@section.project)
    else
      flash.now[:error] = "Sections need a name"
      render :new
    end
  end

  private

  def section_params
    params.require(:section).permit(:name, :project_id)
  end

end