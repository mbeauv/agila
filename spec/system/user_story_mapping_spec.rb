require 'rails_helper'

describe 'User Story Mapping', type: :system do

    let(:user) { create(:user) }
    let(:project) { create(:project, account: user.account) }
    let(:sprint) { create(:sprint, project: project) }
    let(:user_story) { create(:user_story, project: project) }

    before do
        login_as(user, :scope => :user)        
    end

    it "displays No User Story Sprint Mapping when user story sprint mapping list is empty" do
        visit project_sprint_user_story_sprint_mappings_path(project, sprint)
        expect(page).to have_content 'No user story assigned to sprint. Do you want to assign some?'
    end

    it "displays a list of user story sprint mappings" do
        user_story_sprint_mapping = create(:user_story_sprint_mapping, sprint: sprint, user_story: user_story)
        visit project_sprint_user_story_sprint_mappings_path(project, sprint)
        expect(page).to have_content user_story_sprint_mapping.user_story.title
    end

    it "creates a new user story sprint mapping" do
        user_story
        visit project_sprint_user_story_sprint_mappings_path(project, sprint)
        click_on 'New User Story Sprint Mapping'
        select user_story.title, from: 'User story'
        click_on 'Create User Story Sprint Mapping'
        expect(page).to have_content 'User story was successfully mapped to sprint'
    end

    it "deletes a user story sprint mapping" do
        user_story_sprint_mapping = create(:user_story_sprint_mapping, sprint: sprint, user_story: user_story)
        visit project_sprint_user_story_sprint_mappings_path(project, sprint)
        click_on 'Delete'
        expect(page).to have_content 'User story was successfully unmapped from sprint'
    end
end