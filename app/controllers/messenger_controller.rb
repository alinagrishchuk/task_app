require 'reloader/sse'

class MessengerController < ApplicationController
  include ActionController::Live
  before_action :authenticate_user!

  def message
    ActiveRecord::Base.connection_pool.release_connection

    response.headers["Content-Type"] = "text/event-stream"
    redis = Redis.new
    sse = Reloader::SSETasks.new(response.stream)

    redis.psubscribe(['task.*','heartbeat']) do |on|
      on.pmessage do |pattern, event, data|

        if event == 'heartbeat' # check clients connection
          sse.write_heartbeat

        else
          @task = eval(data)['task'].deep_symbolize_keys #prepare task from message

          if @task[:users].map{ |user| user[:id] }.include? current_user.id #user subscribe for task upd
            script = event == 'task.destroyed' ?
                render_to_string(partial: 'tasks/task_del', formats: [:js]) :
                render_to_string(partial: 'tasks/task_upd', formats: [:js])

            sse.write_task script
          end
        end
      end
    end

  rescue ClientDisconnected
    logger.info 'Stream closed'
  ensure
    redis.quit
    sse.close
  end

end
