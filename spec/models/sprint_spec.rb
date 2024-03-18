require 'rails_helper'

RSpec.describe Sprint, type: :model do

  let(:account) { create(:account)}
  let(:project) { create(:project, account: account) }

  subject { build(:sprint, project: project) }

  describe 'project' do
    it { should belong_to(:project) }
  end

  describe 'user_story_sprint_mappings' do
    it { should have_many(:user_story_sprint_mappings).dependent(:destroy) }
  end

  describe 'name' do  
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:project_id) }
  end

  describe 'description' do
    it { should validate_length_of(:description).is_at_most(1000) }
  end

  describe 'start_date' do
    it 'validates presence of start_date when active' do
      sprint = Sprint.new(active: true)
      sprint.valid?
      expect(sprint.errors[:start_date]).to include("can't be blank")
    end
    
    it 'does not validate presence of start_date when not active' do
      sprint = Sprint.new(active: false)
      sprint.valid?
      expect(sprint.errors[:start_date]).not_to include("can't be blank")
    end
  end

  describe 'end_date' do
    it 'validates end_date is after start_date' do
      sprint = Sprint.new(start_date: Date.today, end_date: Date.yesterday)
      sprint.valid?
      expect(sprint.errors[:end_date]).to include("must be after start date")
    end
  end

end
