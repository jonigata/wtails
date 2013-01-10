module Wtails
  module Browser
    extend self

    def run
      if Wtails.config[:serve]
        puts "serve on http://localhost:#{Wtails.config[:port]}"
      else
        # ugly, but there is nothing for it but to poll
        # because thin has no start callback
        while true
          if Wtails.http_server && Wtails.http_server.running?
            break
          end
          sleep(0.1)
        end
        ::Launchy.open("http://localhost:#{Wtails.config[:port]}") rescue nil
      end
    end
  end
end
