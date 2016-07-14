require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'base validation' do
    let(:user_with_tasks) { create(:user_with_tasks, tasks_count: 10 ) }
    it { expect(user_with_tasks).to respond_to(:tasks) }
    it { expect(user_with_tasks.tasks.count).to eq 10 }
  end
end
