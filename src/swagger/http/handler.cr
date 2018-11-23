require "ecr/macros"
require "json"
require "http/server/handler"
module Swagger::HTTP::Handler
  macro included
    include ::HTTP::Handler
    def not_found(context)
      response_with(context, {
        message: "not_found"
      }, status_code: 404)
    end

    def redirect_to(context, uri, status_code = 301)
      context.response.status_code = status_code
      context.response.headers["Location"] = uri
    end

    def response_with(context, body, content_type = "application/json", status_code = 200)
      context.response.status_code = status_code
      context.response.headers["Content-Type"] = content_type
      context.response << body
    end

    def response_with(context, body, headers : ::HTTP::Headers, status_code = 200)
      context.response.status_code = status_code
      context.response.headers.merge!(headers)
      context.response << body
    end

    def match_router?(context, path, method = "GET")
      request = context.request
      request.method == method && ["/#{path}", path, "#{path}/"].includes?(request.path)
    end
  end
end

require "./handers/*"
