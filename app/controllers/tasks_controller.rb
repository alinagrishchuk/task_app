class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]
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

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description)
  end
end
