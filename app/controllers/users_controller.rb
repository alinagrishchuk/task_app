class UsersController < ApplicationController
  before_action :authenticate_user!
  respond_to :js

  def search
    users = Task.find(params[:task_id]).users.ids
    search = params[:search]

    render json: User.email_search_filtered(search, users, 10).simple
  end


end
