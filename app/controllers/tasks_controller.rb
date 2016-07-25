class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :build_task, only: :create
  before_action :set_task, only: [:edit, :update, :destroy, :new_share, :create_share]

  respond_to :js

  def index
    @tasks = current_user.tasks.includes(:users)
  end

  def new
    @task = Task.new
  end

  def create
    create_response(Publisher::TaskPublisher.new(@task).save)
  end

  def update
    create_response(Publisher::TaskPublisher.new(@task).update(task_params))
  end

  def destroy
    create_response(Publisher::TaskPublisher.new(@task).destroy, false)
  end

  def create_share
    @task.association(:users).add_to_target(User.find(share_params[:id]))
    create_response(Publisher::TaskPublisher.new(@task).save)
  end

  private

  def build_task
    @task = Task.new(task_params)
    @task.users << current_user
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description)
  end

  def share_params
    params.require(:user).permit(:email, :id)
  end

  def create_response(successes, show_errors = true )
    if successes
      head 200, content_type: 'text/html'
    elsif show_errors
      render partial: 'validation_errors'
    end
  end
end
