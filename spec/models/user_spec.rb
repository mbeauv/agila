require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'account' do
    subject { build(:user) }

    it { should have_one(:account).dependent(:destroy) }

    it 'creates an account when a user is created' do
      user = create(:user)
      expect(user.account).to be_valid
    end

  end

  describe 'email' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'username' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).case_insensitive }
  end

end
