class UsersController < ApplicationController
  before_action :authenticate_user!
  respond_to :js

  def search
    search = params[:search]
    render json:
             User.email_search(search).select(:email,:id).limit(10).
               map{ |user|  { value: user.id, label:  user.email } }
  end
end
