require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'base validation' do
    let(:user_with_tasks) { create(:user_with_tasks, tasks_count: 10 ) }
    it { expect(user_with_tasks).to respond_to(:tasks) }
    it { expect(user_with_tasks.tasks.count).to eq 10 }
  end

  describe 'search by email' do
    let!(:user_1) { create(:user, email: 'sample@example.com') }
    let!(:user_2) { create(:user, email: 'sample2@example.com') }
    let!(:user_3) { create(:user, email: 'emother_email@example.com') }

    it 'should return empty collection' do
      expect(User.email_search('some_email').count).to eq 0
    end

    it 'should return the filtered & sorted collection' do
      expect(User.email_search('sample').map(&:email)).to eq  ['sample@example.com','sample2@example.com']
    end

  end
end
