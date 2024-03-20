# spec/helpers/application_helper_spec.rb
require 'rails_helper'

describe ApplicationHelper, type: :helper do
  describe 'gravatar_for' do
    let(:user) { double('User', email: 'test@example.com') }

    it 'returns a gravatar image tag' do
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=80"
      expect(helper.gravatar_for(user)).to eq(
        "<img alt=\"#{user.email}\" class=\"gravatar\" src=\"#{gravatar_url}\" />"
      )
    end
  end

  describe 'button_class' do
    it 'returns the CSS class for a primary, normal button' do
      expect(helper.button_class(:primary, :normal)).to eq(
        'bg-blue-500 hover:bg-blue-700 text-white py-2 px-4 font-bold rounded'
      )
    end

    it 'returns the CSS class for an alternate, small button' do
      expect(helper.button_class(:alternate, :small)).to eq(
        'bg-transparent hover:bg-blue-500 text-blue-700 font-semibold hover:text-white border border-blue-500 hover:border-transparent py-1 px-2 font-bold rounded'
      )
    end
  end

  describe 'button' do
    it 'returns a button link with the specified text, path, style, and size' do
      expect(helper.button('Test', '/test')).to eq(
        '<a class="bg-blue-500 hover:bg-blue-700 text-white py-2 px-4 font-bold rounded" data-turbolinks="false" href="/test">Test</a>'
      )
    end
  end

end