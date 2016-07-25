module Reloader
  class SSE
    def initialize io
      @io = io
    end

    def write (event, data)
      @io.write("event: #{event}\ndata: #{data}\n\n")
    end

    def close
      @io.close
    end
  end
end