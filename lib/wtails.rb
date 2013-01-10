require 'rubygems'
require "eventmachine-tail"
require 'websocket-eventmachine-server'

require "sinatra/base"
require "launchy"

require "wtails/version"
require "wtails/web_server"
require "wtails/web_socket"
require "wtails/tail"
require "wtails/stdin"
#require "wtails/browser"

module Wtails
  extend self

  def run(opts, files)
    configure(opts)

    Thread.abort_on_exception = true
    EM.run do
      EM.defer { WebSocket.run(opts, files) }
      EM.defer { WebServer.run(opts, files) }
      #EM.defer { Browser.run }
      Tail.run(opts, files) 
    end
  end

  def channel(path)
    @channel ||= {}
    @channel[path] ||= EM::Channel.new
  end

  def config
    @config
  end

  def http_server
    @http_server
  end

  def http_server=(http_server)
    @http_server = http_server
  end

  private

  def configure(args)
    @config = args
  end
end
