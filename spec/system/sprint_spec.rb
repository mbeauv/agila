require 'rails_helper'

describe 'Sprint Management', type: :system do
    let(:user) { create(:user) }
    let(:project) { create(:project, account: user.account) }

    before do
        login_as(user, :scope => :user)        
    end

    it "displays No Sprint when sprint list is empty" do
        visit project_sprints_path(project)
        expect(page).to have_content 'No sprint. Do you want to create some?'
    end

    it "displays a list of sprints" do
        sprint = create(:sprint, project: project)
        visit project_sprints_path(project)
        expect(page).to have_content sprint.name
    end

    it "creates a new sprint" do
        visit project_sprints_path(project)
        click_on 'New Sprint'
        fill_in 'Name', with: 'New Sprint'
        fill_in 'Description', with: 'New Sprint Description'
        select '2022', from: 'sprint_start_date_1i' # Year
        select 'January', from: 'sprint_start_date_2i' # Month
        select '1', from: 'sprint_start_date_3i' # Day
        select '2023', from: 'sprint_start_date_1i' # Year
        select 'January', from: 'sprint_start_date_2i' # Month
        select '1', from: 'sprint_start_date_3i' # Day
        click_on 'Create Sprint'
        expect(page).to have_content 'Sprint was successfully created'
        expect(page).to have_content 'New Sprint'
    end

    it "updates a sprint" do
        user_story = create(:sprint, project: project)
        visit project_sprints_path(project)
        click_on 'Edit'
        fill_in 'Name', with: 'Updated Sprint'
        click_on 'Update Sprint'
        expect(page).to have_content 'Sprint was successfully updated'
        expect(page).to have_content 'Updated Sprint'
    end

    it "deletes a sprint" do
        user_story = create(:sprint, project: project)
        visit project_sprints_path(project)
        click_on 'Delete'
        expect(page).to have_content 'Sprint was successfully deleted'
        expect(page).to have_content 'No sprint. Do you want to create some?'
    end
end
