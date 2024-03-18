require 'rails_helper'

describe UserStorySprintMapping, type: :model do

  let(:project) { create(:project) }
  let(:user_story) { create(:user_story, project: project) }
  let(:sprint) { create(:sprint, project: project) }

  subject { described_class.new(user_story: user_story, sprint: sprint) }

  describe 'user_story' do
    it { should belong_to(:user_story) }
    it { should validate_uniqueness_of(:user_story) }
  end

  describe 'sprint' do
    it { should belong_to(:sprint) }
  end

end
