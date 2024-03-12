require 'rails_helper'

describe "Project Browsing", type: :system do

  it "displays No Project when project list is empty" do
    # First, login as a user
    user = create(:user)
    login_as(user, :scope => :user)
    visit '/projects'
    expect(page).to have_content 'No project. You can create one.'
  end

end