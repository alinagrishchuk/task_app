require 'reloader/sse'

module Messenger
  class TaskMessenger
    include ActionController::Live
    include TaskMessengerUtilities

    def initialize(controller, user_id)
      @io = Reloader::SSE.new(controller.response.stream)
      @controller, @user  = controller, user_id
      @redis = Redis.new
      set_header
    end

    def set_header
      @controller.response.headers["Content-Type"] = "text/event-stream"
    end

    def subscribe
      @redis.psubscribe(['task.*','heartbeat']) do |on|
        on.pmessage do |pattern, event, data|
          if event == 'heartbeat'
            write_heartbeat
          else
            write_task event, data
          end
        end
      end

    rescue ClientDisconnected
    ensure
      @redis.quit
      @io.close
    end

    def write_heartbeat
      @io.write('heartbeat','heartbeat')
    end

    def write_task(event, data)
      task = prepare_task(data, @user)
      if task
        partial = prepare_partial(event)
        message = generate_script(partial, task)
        @io.write('tasks.updated',message)
      end
    end

    def generate_script(partial, task)
      script = render(partial, task)
      script.gsub("\n", '')
    end

    def render (partial, task)
      @controller.render_to_string(partial: partial,
                                   locals: { task: task },
                                   formats: [:js])
    end
  end
end