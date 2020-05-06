require "ecr/macros"
require "json"
require "uri"

module Swagger::HTTP
  class WebHandler
    include Swagger::HTTP::Handler

    SWAGGER_WEB_URI = "/swagger"
    DEMO_API_URL    = "https://petstore.swagger.io/v2/swagger.json"

    def initialize(@route = SWAGGER_WEB_URI, @api_url : String = DEMO_API_URL, @asset_dir : String = assets_path)
      @static_file_handler = ::HTTP::StaticFileHandler.new(assets_path, directory_listing: false)
    end

    def call(context)
      if web_uri?(context)
        render_web(context)
      elsif asset_uri?(context)
        @static_file_handler.call(context)
      else
        call_next(context)
      end
    end

    private def render_web(context)
      context.response.status_code = 200
      context.response.headers["Content-Type"] = "text/html"
      render(context.response, @api_url, "Swagger API")
    end

    private def web_uri?(context)
      match_router?(context, @route)
    end

    private def asset_uri?(context)
      original_path = context.request.path.not_nil!
      is_dir_path = original_path.ends_with?("/")
      request_path = self.request_path(URI.decode_www_form(original_path))

      expanded_path = File.expand_path(request_path, "/")
      if is_dir_path && !expanded_path.ends_with? "/"
        expanded_path = "#{expanded_path}/"
      end
      is_dir_path = expanded_path.ends_with? "/"

      file_path = File.join(@asset_dir, expanded_path)
      is_dir = Dir.exists?(file_path)
      !is_dir && File.exists?(file_path)
    end

    private def api_uri?(api_handler, context)
      api_handler.match?(context)
    end

    private def render(io, openapi_url, title)
      ECR.embed("#{__DIR__}/../views/swagger.ecr", io)
    end

    def assets_path
      File.expand_path("../assets", __DIR__)
    end

    protected def request_path(path : String) : String
      path
    end
  end
end
