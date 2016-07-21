class TasksController < ApplicationController
  include MessageFactory
  before_action :set_task, only: [:edit, :update, :destroy, :new_share, :create_share]
  before_action :authenticate_user!

  respond_to :js

  def index
    @tasks = current_user.tasks.includes(:users)
    respond_to do |format|
      format.html {}
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.users << current_user
    if @task.save
      $redis.publish('task.saved', create_message(@task))
      head 200, content_type: 'text/html'
    else
      render partial: 'validation_errors'
    end
  end

  def update
    if @task.update(task_params)
      $redis.publish('task.saved', create_message(@task))
      head 200, content_type: 'text/html'
    else
      render partial: 'validation_errors'
    end
  end

  def destroy
    message = create_message(@task)
    if @task.destroy
      $redis.publish('task.destroyed', message)
      head 200, content_type: 'text/html'
    end
  end

  def create_share
    if @task.users << (User.find(share_params[:id]))
      $redis.publish('task.share', create_message(@task))
      head 200, content_type: 'text/html'
    else
      render partial: 'validation_errors'
    end
  end

  private
  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description)
  end

  def share_params
    params.require(:user).permit(:email, :id)
  end
end
