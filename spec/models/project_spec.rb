require 'rails_helper'

RSpec.describe Project, type: :model do

  let(:account) { create(:account)}

  subject { build(:project, account: account) }

  describe 'account' do
    it { should belong_to(:account) }
  end

  describe "sprints" do
    it { should have_many(:sprints).dependent(:destroy) }
  end
  
  describe 'user_stories' do
    it { should have_many(:user_stories).dependent(:destroy) }
  end

  describe 'name' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(100) }
  end

  describe 'description' do
    it { should validate_length_of(:description).is_at_most(1000) }
    it { should allow_value(nil).for(:description) }
  end

  describe 'start_date' do
    (Project.statuses.keys - ['not_started']).each do |status|
      it "is required when status is #{status}" do
        project = Project.new(name: 'Test Project', description: 'Test Description', start_date: nil, status: status)
        expect(project.valid?).to be(false)
        expect(project.errors[:start_date]).to include("is required when status is '#{status}'")
      end
    end
  end

  describe 'unmapped_user_stories' do
    it 'returns user stories that are not mapped to a sprint' do
      project = create(:project)
      user_story = create(:user_story, project: project)
      sprint = create(:sprint, project: project)
      expect(project.unmapped_user_stories).to include(user_story)
    end

    it 'does not return user stories that are mapped to a sprint' do
      project = create(:project)
      user_story = create(:user_story, project: project)
      sprint = create(:sprint, project: project)
      create(:user_story_sprint_mapping, user_story: user_story, sprint: sprint)
      expect(project.unmapped_user_stories).to_not include(user_story)
    end
  end
end
