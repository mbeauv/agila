require 'rails_helper'

RSpec.describe Account, type: :model do

  let(:user) { create(:user) }

  describe 'user' do
    it { should belong_to(:user) }
  end

  describe 'projects' do
    it { should have_many(:projects).dependent(:destroy) }
  end
  
end