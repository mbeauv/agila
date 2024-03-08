# app/controllers/projects_controller.rb

class ProjectsController < ApplicationController
    def index
      # Get all projects sorted by name
      @projects = Project.order(:name)
    end
  
    def show
      @project = Project.find(params[:id])
    end
  
    def new
      @project = Project.new
    end
  
    def create
      @project = Project.new(project_params)
      if @project.save
        # Redirect to the project's show page and display flash message
        flash[:notice] = "Project was successfully created"
        redirect_to @project
      else
        render :new
      end
    end
  
    def edit
      @project = Project.find(params[:id])
    end
  
    def update
      @project = Project.find(params[:id])
      if @project.update(project_params)
        flash[:notice] = "Project was successfully updated"
        redirect_to @project
      else
        render :edit
      end
    end
  
    def destroy
      @project = Project.find(params[:id])
      @project.destroy
      flash[:notice] = "Project #{@project.name} was successfully deleted"
      redirect_to projects_path
    end
  
    private
  
    def project_params
      params.require(:project).permit(:name, :description, :status, :start_date)
    end
  end