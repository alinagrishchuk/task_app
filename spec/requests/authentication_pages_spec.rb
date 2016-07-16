require 'rails_helper'

describe 'Authentication', :type => :request do
  subject { page }

  describe 'signin page' do
    before { visit  root_path }

    it { should have_content('Log in') }
    it { should_not have_link('Sign out', href: destroy_user_session_path) }

    describe 'with invalid information' do
      before { click_button 'Log in' }
      it { should have_content('Invalid') }
    end

    describe 'with valid information' do
      let!(:user) { create(:user) }
      before { valid_signin user }

      it { should have_link('Sign Out') }
    end
  end
end