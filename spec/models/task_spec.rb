require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'base validation' do
    let(:task_with_user) { create(:task) }

    describe "when hasn't users " do
      let(:task) { build(:sample_task) }
      it {  expect(task).not_to be_valid }
    end

    it { expect(task_with_user).to respond_to(:title) }
    it { expect(task_with_user).to respond_to(:description) }
    it { expect(task_with_user).to respond_to(:users) }
  end


end
