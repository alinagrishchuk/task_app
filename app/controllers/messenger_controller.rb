class MessengerController < ApplicationController
  include ActionController::Live

  def message
    ActiveRecord::Base.connection_pool.release_connection
    Messenger::TaskMessenger.new(self,current_user.id).subscribe
  end
end
