require 'rails_helper'

RSpec.describe Project, type: :model do

  let(:account) { create(:account)}

  subject { build(:project, account: account) }

  describe 'account' do
    it { should belong_to(:account) }
  end

  describe 'name' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(100) }
  end

  describe 'description' do
    # it should be at most 1000 characters
    it { should validate_length_of(:description).is_at_most(1000) }

    # it should be optional
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
end
