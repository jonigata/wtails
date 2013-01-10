module Wtails
  module WebSocket
    extend self

    LOG_SIZE = 100

    def run(opts, files)
      port = opts[:port]
      @servers = files.map do |file|
        port += 1
        Server.new(file, port)
      end
    end

    def servers
      @servers ||= []
    end

    class Server
      def initialize(file, port)
        @file = file
        @port = port
        @logs = []
        @channel = Wtails.channel(file)
        @channel.subscribe do |msg|
          @logs << msg
          @logs.shift if @logs.size > LOG_SIZE
        end

        opts = {:host => "0.0.0.0", :port => port}
        s = ::WebSocket::EventMachine::Server.start(opts) do |socket|
          socket.onopen(&onopen(socket))
          socket.onmessage(&onmessage)
          socket.onerror(&onerror)
        end

        def onopen(socket)
          proc do
            send_message = proc do |message|
              next unless message
              str = message.respond_to?(:force_encoding) ?
              message.force_encoding("UTF-8") :
                message

              socket.send(str)
            end

            @logs.each(&send_message)
            id = @channel.subscribe(&send_message)

            socket.onclose do
              @channel.unsubscribe(id)
            end
          end
        end

        def onmessage
          proc do |message|
            @channel << message
          end
        end

        def onerror
          proc do |error|
            puts error
          end
        end
      end

      attr_reader :port
      attr_reader :file
    end
  end
end
