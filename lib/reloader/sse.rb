module Reloader
  class SSETasks
    def initialize io
      @io = io
    end

    def write_heartbeat
      @io.write("event: heartbeat\ndata: heartbeat\n\n")
    end

    def write_task script
      message = script.gsub("\n", '')
      @io.write("event: tasks.updated\n")
      @io.write("data: #{message}\n\n")
    end

    def close
      @io.close
    end
  end
end