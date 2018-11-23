require "json"

module Swagger::HTTP
  class APIHandler
    include Swagger::HTTP::Handler

    def self.new(document : Document, endpoint : String, debug_mode = true)
      json = document.to_json
      new(json, endpoint)
    end

    def initialize(@json : String, @endpoint : String, @debug_mode = true)
    end

    def call(context)
      return call_next(context) unless match?(context)

      context.response.headers["Access-Control-Allow-Origin"] = "*" if @debug_mode
      response_with(context, @json)
    end

    def match?(context)
      match_router?(context, swagger_path)
    end

    def api_url
      uri = URI.parse(@endpoint)
      uri.path = swagger_path
      uri.to_s
    end

    private def swagger_path
      "/v#{Swagger::OPENAPI_MAJAR_VERSION}/swagger.json"
    end
  end
end
