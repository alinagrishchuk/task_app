class UsersController < ApplicationController
  before_action :authenticate_user!
  respond_to :js

  def search
    users = Task.find(params[:task_id]).users.pluck(:id)
    search = params[:search]
    render json: User.email_search(search).
        where.not(id: users).
        select(:email,:id).limit(10).
        map{ |user|  { value: user.id, label:  user.email } }
  end
end
