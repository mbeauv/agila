require 'rails_helper'

describe "Project Browsing", type: :system do

  let(:user) { create(:user) }

  it "displays No Project when project list is empty" do
    login_as(user, :scope => :user)
    visit '/projects'
    expect(page).to have_content 'No project. You can create one.'
  end

  it "displays a list of projects" do
    project = create(:project, account: user.account)
    login_as(user, :scope => :user)
    visit '/projects'
    expect(page).to have_content project.name
  end

  it "creates a new project" do
    login_as(user, :scope => :user)
    visit '/projects'
    click_on 'New Project'
    fill_in 'Name', with: 'New Project'
    click_on 'Save'
    expect(page).to have_content 'Project was successfully created'
    expect(page).to have_content 'New Project'
  end

  it "updates a project" do
    project = create(:project, account: user.account)
    login_as(user, :scope => :user)
    visit '/projects'
    click_on 'Edit'
    fill_in 'Name', with: 'Updated Project'
    click_on 'Update Project'
    expect(page).to have_content 'Project was successfully updated'
    expect(page).to have_content 'Updated Project'
  end

  it "deletes a project" do
    project = create(:project, account: user.account)
    login_as(user, :scope => :user)
    visit '/projects'
    click_on 'Delete'
    expect(page).to have_content 'Project was successfully deleted'
    expect(page).to have_content 'No project. You can create one.'
  end

end