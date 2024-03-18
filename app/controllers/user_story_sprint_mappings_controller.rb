class UserStorySprintMappingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_sprint

  def index
    @user_story_sprint_mappings = @sprint.user_story_sprint_mappings
  end

  def new
    @user_story_sprint_mapping = UserStorySprintMapping.new
    @user_stories = @project.unmapped_user_stories    
  end

  def create
    @user_story_sprint_mapping = UserStorySprintMapping.new(user_story_sprint_mapping_params)
    @user_story_sprint_mapping.sprint = @sprint
    if @user_story_sprint_mapping.save
      redirect_to project_sprint_user_story_sprint_mappings_path(@project, @sprint), notice: 'User story was successfully mapped to sprint.'
    else
      @user_stories = @project.unmapped_user_stories
      render :new
    end
  end

  def destroy
    @user_story_sprint_mapping = UserStorySprintMapping.find(params[:id])
    @user_story_sprint_mapping.destroy
    redirect_to project_sprint_user_story_sprint_mappings_path(@project, @sprint), notice: 'User story was successfully unmapped from sprint.'
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_sprint
    @sprint = Sprint.find(params[:sprint_id])
  end

  def user_story_sprint_mapping_params
    params.require(:user_story_sprint_mapping).permit(:user_story_id)
  end

end
