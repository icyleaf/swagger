require "http/server"
require "./handler"

module Swagger::HTTP
  class Server
    def self.run(document : Document, swagger_uri = HTTP::WebHandler::SWAGGER_WEB_URI, host = "127.0.0.1", port = 8080)
      new(host, port, swagger_uri).run(document)
    end

    def initialize(@host : String, @port : Int32, @swagger_uri : String)
      @swagger_uri = fix_uri(@swagger_uri)
    end

    def run(document : Document)
      puts "Your API document is ready ... #{server_endpoint}"
      server(document).listen
    end

    def server(document)
      api_handler = HTTP::APIHandler.new(document, server_endpoint)

      server = ::HTTP::Server.new([
        api_handler,
        HTTP::WebHandler.new(@swagger_uri, api_handler.api_url),
      ])
      server.bind_tcp @host, @port
      server
    end

    @server_endpoint : String?

    def server_endpoint
      @server_endpoint ||= "http://#{@host}:#{@port}#{@swagger_uri}"
      @server_endpoint.not_nil!
    end

    private def fix_uri(uri)
      uri[0] == '/' ? uri : "/#{uri}"
    end
  end
end
