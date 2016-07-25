require 'rails_helper'

RSpec.feature  'Sending update', :type => :features do
  subject { page }

  let!(:user) { create(:user_with_tasks, tasks_count: 1) }
  let(:first_created_task) { Task.last }
  let(:share_user) { create(:user) }
  let(:sample_user) { create(:user) }

  describe 'for correct user', :js => true do
    before do
      login_as(share_user, :scope => :user)
      visit '/'
    end

    it 'should display task' do
      share_user.tasks << first_created_task

      messenger = Class.new.send(:include, Messenger::MessageFactory).new
      $redis.publish('task.share',
                     messenger.create_task_message(first_created_task.reload))
      sleep 2
      should have_selector("div#task_#{first_created_task.id}")
    end
  end

  describe 'for incorrect user', :js => true do
    before do
      login_as(sample_user, :scope => :user)
      visit '/'
    end

    it 'should not display task' do
      share_user.tasks << first_created_task

      messenger = Class.new.send(:include, Messenger::MessageFactory).new
      $redis.publish('task.share',
                     messenger.create_task_message(first_created_task.reload))
      sleep 2
      should_not have_selector("div#task_#{first_created_task.id}")
    end
  end


end