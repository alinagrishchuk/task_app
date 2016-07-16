require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  subject { page }
  let!(:user) { create(:user_with_tasks, tasks_count: 2) }


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
        should_not have_selector(".task-form")
        find('.js-edit-task').click

        should have_selector(".task-form")
        fill_in 'Title',          with: ''
        fill_in 'Description',    with: ''
        expect { submit_form }.not_to change(Task, :count)
        should have_selector("ul.errors>li")
      end
    end

    it 'should edit a task and append task list', :js => true do
      within "#task_#{first_created_task.id}"  do
        should_not have_selector(".task-form")
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
        should_not have_selector(".task-form")
        find('.js-edit-task').click

        click_cancel
        should_not have_selector(".task-form")
      end
    end
  end
end