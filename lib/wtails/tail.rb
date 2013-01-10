module Wtails
  module Tail
    extend self

    ENTITY_MAP = {
      "&lt;" => "<",
      "&gt;" => ">",
    }

    def run(opts, files)
      files.each do |path|
        if path == '-'
          EM.defer { Wtails::Stdin.run }
        else
          EventMachine::file_tail(path, Reader)
        end          
      end
    end

    class Reader < EventMachine::FileTail
      def initialize(path, startpos=-1)
        super(path, startpos)
        @buffer = BufferedTokenizer.new
      end

      def receive_data(data)
        @buffer.extract(data).each do |line|
          Wtails.channel(path) << line
        end
      end
    end
  end
end
