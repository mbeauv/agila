
class SprintsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_project

  def index
    @sprints = @project.sprints.order(:start_date)
  end

  def new
    @sprint = @project.sprints.new
  end

  def create
    @sprint = @project.sprints.new(sprint_params)
    if @sprint.save
      flash[:notice] = "Sprint was successfully created"
      redirect_to project_sprints_path(@project)
    else
      render :new
    end
  end

  def edit
    @sprint = @project.sprints.find(params[:id])
  end

  def update
    @sprint = @project.sprints.find(params[:id])
    if @sprint.update(sprint_params)
      flash[:notice] = "Sprint was successfully updated"
      redirect_to project_sprints_path(@project)
    else
      render :edit
    end
  end

  def show
    @sprint = @project.sprints.find(params[:id])
  end

  def destroy
    @sprint = @project.sprints.find(params[:id])
    @sprint.destroy
    flash[:notice] = "Sprint was successfully deleted"
    redirect_to project_sprints_path(@project)
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def sprint_params
    params.require(:sprint).permit(:name, :description, :start_date, :end_date, :active)
  end

end
