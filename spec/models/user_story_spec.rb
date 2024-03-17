require 'rails_helper'

RSpec.describe UserStory, type: :model do

  let(:account) { create(:account)}
  let(:project) { create(:project, account: account)}
  subject { build(:user_story, project: project) }

  describe 'project' do
    it { should belong_to(:project) }
  end

  describe 'title' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(3).is_at_most(100) }
  end

  describe 'description' do
    it { should validate_length_of(:description).is_at_most(1000) }
  end

  describe 'estimate' do
    it { should validate_numericality_of(:estimate).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:estimate).only_integer }
  end


  # Scopes
  it { should define_enum_for(:status).with_values(%i[not_started in_progress completed cancelled paused]) }

  # Callbacks
  # it { should callback(:set_default_status).before(:validation).on(:create) }

  # Methods
  describe '#set_default_status' do
    it 'sets the default status to not_started' do
      user_story = UserStory.new
      user_story.set_default_status
      expect(user_story.status).to eq('not_started')
    end
  end

  # Private Methods
  # describe '#start_date_required_when_started' do
  #   it 'requires start_date when status is not_started' do
  #     user_story = UserStory.new(status: 'not_started')
  #     user_story.valid?
  #     expect(user_story.errors[:start_date]).to include("is required when status is 'not_started'")
  #   end
  # end

end
