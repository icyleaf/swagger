require "json"

require "./header"
require "./media_type"
require "./link"

module Swagger::Objects
  # Response Object
  #
  # See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.3.md#responsesObject
  struct Response
    include JSON::Serializable

    getter description : String
    getter headers : Hash(String, Header)? = nil
    getter content : Hash(String, MediaType)? = nil
    getter links : Array(Link)? = nil

    @[JSON::Field(key: "$ref")]
    getter ref : String? = nil

    def initialize(@description : String, @headers : Hash(String, Header)? = nil,
                   @content : Hash(String, MediaType)? = nil, links : Array(Link)? = nil,
                   @ref : String? = nil)
    end
  end
end
