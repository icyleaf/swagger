require "json"

module Swagger::HTTP
  class APIHandler
    include Swagger::HTTP::Handler

    def self.new(document : Document, endpoint : String)
      json = document.to_json
      new(json, endpoint)
    end

    def initialize(@json : String, @endpoint : String)
    end

    def call(context)
      if match?(context)
        response_with(context, @json)
      else
        call_next(context)
      end
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
