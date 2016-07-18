class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy, :new_share, :create_share]
  before_action :authenticate_user!

  respond_to :js

  def index
    @tasks = Task.all.includes(:users)
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
    @task.save
  end

  def update
    @task.update task_params
  end


  def destroy
    @task.destroy
  end


  def create_share
    @task.users << ( User.find(share_params[:id]))
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description)
  end

  def share_params
    params.require(:user).permit(:email, :id)
  end
end
