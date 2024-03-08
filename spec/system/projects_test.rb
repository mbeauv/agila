require 'rails_helper'

describe "Project Management", type: :feature do
  
    describe "Project Browsing" do

      it "displays No Project when project list is empty" do
        visit '/projects'
        expect(page).to have_content 'No project. You can create one.'
      end

      it "displays projects in alphabetical order" do
        project3 = FactoryBot.create(:project, name: 'proj3')
        project1 = FactoryBot.create(:project, name: 'proj1')
        project2 = FactoryBot.create(:project, name: 'proj2')
        visit '/projects'
        expect(page).to have_content 'proj1'
        expect(page).to have_content 'proj2'
        expect(page).to have_content 'proj2'
        expect(page.body.index('proj1')).to be < page.body.index('proj2')
        expect(page.body.index('proj2')).to be < page.body.index('proj3')
      end

    end

    describe "Project Creation" do

      it "allows for the creation of a project" do
        visit '/projects/new'
        fill_in 'Name', with: 'proj1'
        fill_in 'Description', with: 'proj1 description'
        click_button 'Create Project'
        expect(page.current_path).to eq "/projects/#{Project.first.id}"
        expect(page).to have_content 'Project was successfully created'
      end

    end

    describe "Project Deletion" do

      it "allows for the deletion of a project for the index page" do
        project = FactoryBot.create(:project)
        visit "/projects"
        click_link 'Delete'
        expect(page.current_path).to eq '/projects'
        expect(page).to have_content "Project #{project.name} was successfully deleted"
      end
  
    end

    describe "Project Modification" do

      it "allows for the modification of a project" do
        project = FactoryBot.create(:project)
        visit "/projects/#{project.id}/edit"
        fill_in 'Name', with: 'proj2'
        fill_in 'Description', with: 'proj2 description'
        click_button 'Update Project'
        expect(page.current_path).to eq "/projects/#{project.id}"
        expect(page).to have_content 'Project was successfully updated'
      end
  
    end

end