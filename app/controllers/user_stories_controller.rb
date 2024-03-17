class UserStoriesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_project

  def index
    @user_stories = @project.user_stories.order(:title)
  end
  
  def new
    @user_story = @project.user_stories.new
  end

  def create
    @user_story = @project.user_stories.new(user_story_params)
    if @user_story.save
      flash[:notice] = "User story was successfully created"
      redirect_to project_user_stories_path(@project)
    else
      render :new
    end
  end

  def edit
    @user_story = @project.user_stories.find(params[:id])
  end

  def update
    @user_story = @project.user_stories.find(params[:id])
    if @user_story.update(user_story_params)
      flash[:notice] = "User story was successfully updated"
      redirect_to project_user_stories_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @user_story = @project.user_stories.find(params[:id])
    @user_story.destroy
    flash[:notice] = "User story was successfully deleted"
    redirect_to project_user_stories_path(@project)
  end

  private

  def user_story_params
    params.require(:user_story).permit(:title, :description, :status, :estimate)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
