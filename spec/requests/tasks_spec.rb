require 'rails_helper'

RSpec.describe 'Tasks page', type: :request do
  subject { page }

  let!(:user) { create(:user_with_tasks, tasks_count: 3) }
  let(:first_created_task) { Task.last }
  let(:last_created_task) { Task.first }

  before(:each) do
    login_as(user, :scope => :user)
    visit root_path
  end

  describe 'task creation' do
    let(:last_created_task) { Task.first }

    it 'should not create a task and show validations error', :js => true do
      click_link 'new_link'
      should_have_form
      submit_form
      should have_selector("ul.errors>li")
    end

    it 'should create a task and append task list', :js => true do
      click_link 'new_link'
      should_have_form

      fill_and_submit_task('some title','some description')

      should_not have_selector("#new_task")
      should have_selector("div#task_#{last_created_task.id}")
    end

    it 'should hide create form', :js => true do
      click_link 'new_link'
      should_have_form

      click_cancel
      should_not_have_form
    end
  end

  describe 'task editing' do
    it 'should not save a task and show validations error', :js => true do
      within "#task_#{first_created_task.id}"  do
        should_not_have_form
        find('.js-edit-task').click

        should_have_form
        fill_and_submit_task('','')

        should have_selector("ul.errors>li")
      end
    end

    it 'should edit a task and append task list', :js => true do
      within "#task_#{first_created_task.id}"  do
        should_not_have_form
        find('.js-edit-task').click

        fill_and_submit_task('new title','new description')

      end

      should have_selector("#task_#{first_created_task.id}")
      should have_content('new title')
      should have_content('new description')
    end

    it 'should hide editing form', :js => true do
      within "#task_#{first_created_task.id}"  do
        should_not_have_form
        find('.js-edit-task').click

        click_cancel
        should_not_have_form
      end
    end
  end

  describe 'task deleting' do
    it 'should delete a task and remove it from list', :js => true do
      within "#task_#{first_created_task.id}"  do
        find('.js-delete-task').click
        sleep 3
      end
      should_not have_selector("#task_#{first_created_task.id}")
    end

  end

  describe 'share task' do
    let(:email) { 'some_email@example.com' }
    let!(:new_user) { create(:user, email: email) }

    it 'should not share a task with empty user email', :js => true do
      within "#task_#{first_created_task.id}"  do
        should_not_have_form
        find('.js-share-task').click

        should_have_form
      end
    end

    it 'should share a task with user', :js => true do
      within "#task_#{first_created_task.id}"  do
        should_not_have_form
        find('.js-share-task').click

        init_and_click_typehead_search('user_email', email)
        submit_form

      end
      should have_selector("#task_#{first_created_task.id}")
      should have_content(email)
    end
  end

  describe 'js link binding' do
    let(:email) { 'some_email@example.com' }
    let!(:new_user) { create(:user, email: email) }

    before do
      append_task_list
    end

    it 'should init share search ', :js => true do
      within "#task_#{last_created_task.id}"  do
        find('.js-share-task').click
        init_typehead_search('user_email', email)
        should have_selector('.tt-suggestion')
        click_cancel
        should_not have_selector(".form-section")
      end
    end

    it 'should bind edit link', :js => true do
      within "#task_#{last_created_task.id}"  do
        should_not_have_form
        find('.js-edit-task').click
        should_have_form
        click_cancel
        should_not_have_form
      end
    end
  end
end