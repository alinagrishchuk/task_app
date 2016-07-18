require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  subject { page }
  let!(:user) { create(:user_with_tasks, tasks_count: 3) }

  describe 'task creation' do
    let(:last_created_task) { Task.first }
    before do
      valid_signin(user)
    end

    it 'should not create a task and show validations error', :js => true do
      click_link 'new_link'

      should have_selector("#new_task")
      expect { submit_form }.not_to change(Task, :count)
      should have_selector("ul.errors>li")
    end

    it 'should create a task and append task list', :js => true do
      click_link 'new_link'
      should have_selector("#new_task")

      fill_in 'Title',          with: 'some title'
      fill_in 'Description',    with: 'some description'
      expect { submit_form }.to change(Task, :count)

      should_not have_selector("#new_task")
      should have_selector("div#task_#{last_created_task.id}")

    end

    it 'should hide create form', :js => true do
      click_link 'new_link'
      should have_selector("#new_task")

      click_cancel
      should_not have_selector("#new_task")
    end
  end

  describe 'task editing' do
    let(:first_created_task) { Task.last }
    before do
      valid_signin(user)
    end

    it 'should not save a task and show validations error', :js => true do
      within "#task_#{first_created_task.id}"  do
        should_not have_selector(".form-section")
        find('.js-edit-task').click

        should have_selector(".form-section")
        fill_in 'Title',          with: ''
        fill_in 'Description',    with: ''
        expect { submit_form }.not_to change(Task, :count)
        should have_selector("ul.errors>li")
      end
    end

    it 'should edit a task and append task list', :js => true do
      within "#task_#{first_created_task.id}"  do
        should_not have_selector(".form-section")
        find('.js-edit-task').click

        fill_in 'Title',          with: 'new title'
        fill_in 'Description',    with: 'new description'

        expect { submit_form }.not_to change(Task, :count)
      end

      should have_selector("#task_#{first_created_task.id}")
      should have_content('new title')
      should have_content('new description')
    end

    it 'should hide editing form', :js => true do
      within "#task_#{first_created_task.id}"  do
        should_not have_selector(".form-section")
        find('.js-edit-task').click

        click_cancel
        should_not have_selector(".form-section")
      end
    end
  end

  describe 'task deleting' do
    let!(:first_created_task) { Task.last }
    let!(:count) { Task.count }

    before do
      valid_signin(user)
    end

    it 'should delete a task and remove it from list', :js => true do
      within "#task_#{first_created_task.id}"  do
        find('.js-delete-task').click
        sleep 1
        expect(count).not_to eq(Task.count)
      end
      should_not have_selector("#task_#{first_created_task.id}")
    end

  end

  describe 'share task' do
    let!(:first_created_task) { Task.last }
    let!(:new_user) { create(:user, email: 'some_email@example.com') }
    let!(:count) { first_created_task.users.count }

    before do
      valid_signin(user)
    end

    it 'should not share a task with empty user email', :js => true do
      within "#task_#{first_created_task.id}"  do
        should_not have_selector(".form-section")
        find('.js-share-task').click

        should have_selector(".form-section")
        expect { submit_form }.not_to change(first_created_task.users, :count)
      end
    end

    it 'should share a task with user', :js => true do
      within "#task_#{first_created_task.id}"  do
        should_not have_selector(".form-section")
        find('.js-share-task').click

        init_typehead_search('user_email', 'email@example.com')
        click_typehead_search('email@example.com')
        submit_form

        expect(first_created_task.reload.users.count).not_to(equal(count))
      end
      should have_selector("#task_#{first_created_task.id}")
      should have_content('some_email@example.com')
    end
  end

  describe 'js link binding' do
    let(:last_created_task) { Task.first }
    let!(:new_user) { create(:user, email: 'some_email@example.com') }
    before do
      valid_signin(user)
      append_task_list
    end

    it 'should init share search ', :js => true do
      within "#task_#{last_created_task.id}"  do
        find('.js-share-task').click
        init_typehead_search('user_email', 'email@example.com')
        should have_selector('.tt-suggestion')
        click_cancel
        should_not have_selector(".form-section")
      end
    end

    it 'should bind edit link', :js => true do
      within "#task_#{last_created_task.id}"  do
        should_not have_selector(".form-section")
        find('.js-edit-task').click
        should have_selector(".form-section")
        click_cancel
        should_not have_selector(".form-section")
      end
    end
  end
end