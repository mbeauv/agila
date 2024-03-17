require 'rails_helper'

describe 'User Stories Management', type: :system do
    let(:user) { create(:user) }
    let(:project) { create(:project, account: user.account) }

    before do
        login_as(user, :scope => :user)        
    end

    it "displays No User Story when user story list is empty" do
        visit project_user_stories_path(project)
        expect(page).to have_content 'No user story. Do you want to create some?'
    end

    it "displays a list of user stories" do
        user_story = create(:user_story, project: project)
        visit project_user_stories_path(project)
        expect(page).to have_content user_story.title
    end

    it "creates a new user story" do
        visit project_user_stories_path(project)
        click_on 'New User Story'
        fill_in 'Title', with: 'New User Story'
        fill_in 'Description', with: 'New User Story Description'
        fill_in 'Estimate', with: 3
        click_on 'Create User story'
        expect(page).to have_content 'User story was successfully created'
        expect(page).to have_content 'New User Story'
    end

    it "updates a user story" do
        user_story = create(:user_story, project: project)
        visit project_user_stories_path(project)
        click_on 'Edit'
        fill_in 'Title', with: 'Updated User Story'
        click_on 'Update User story'
        expect(page).to have_content 'User story was successfully updated'
        expect(page).to have_content 'Updated User Story'
    end

    it "deletes a user story" do
        user_story = create(:user_story, project: project)
        visit project_user_stories_path(project)
        click_on 'Delete'
        expect(page).to have_content 'User story was successfully deleted'
        expect(page).to have_content 'No user story. Do you want to create some?'
    end
end
