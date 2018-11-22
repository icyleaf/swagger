require "ecr/macros"
require "json"

module Swagger::HTTP
  class WebHandler
    include Swagger::HTTP::Handler

    SWAGGER_WEB_URI = "/swagger"
    DEMO_API_URL = "https://petstore.swagger.io/v2/swagger.json"

    def initialize(@route = SWAGGER_WEB_URI, @api_url : String = DEMO_API_URL)
    end

    def call(context)
      web_uri?(context) ? render_web(context) : call_next(context)
    end

    private def render_web(context)
      context.response.status_code = 200
      context.response.headers["Content-Type"] = "text/html"
      swagger_body(context.response, @api_url, "Swagger API")
    end

    private def web_uri?(context)
      match_router?(context, @route)
    end

    private def api_uri?(api_handler, context)
      api_handler.match?(context)
    end

    private def swagger_body(io, openapi_url, title)
      ECR.embed("#{__DIR__}/../views/swagger.ecr", io)
    end
  end
end
