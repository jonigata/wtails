module Wtails
  module WebServer
    extend self

    def run(opts, files)
      ::Rack::Handler::Thin.run(
        Server.new,
        :Port => opts[:port]
        ) do |http_server|
        Wtails.http_server = http_server
      end
    end

    class Server < ::Sinatra::Base
      set :wtailsrc do
        path = File.expand_path(Wtails.config[:rc])
        File.exist?(path) && File.read(path)
      end
      set :views, File.expand_path("../../../views/", __FILE__)
      set :public, File.expand_path("../../../public/", __FILE__)

      get "/" do
        redirect "/single"
      end
    
      get "/single" do
        erb :single, :locals => make_local_variables
      end
    
      get "/dual" do
        erb :dual, :locals => make_local_variables
      end
    
      get "/test" do
        erb :test
      end

      def make_local_variables
        {
          :files    => WebSocket.servers.map { |s| [s.file, s.port] },
          :wtailsrc => settings.wtailsrc,
        }
      end

    end
  end
end
