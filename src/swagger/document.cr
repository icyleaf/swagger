module Swagger
  struct Document
    include JSON::Serializable

    getter openapi = Swagger::OPENAPI_VERSION
    getter info
    getter paths

    def initialize(@info : Object::Info, @paths : Hash(String, Object::PathItem),
                   @servers : Array(Object::Server)? = nil, @tags : Array(Object::Tag)? = nil,
                   @components : Hash(String, Object::Schema)? = nil)
    end
  end
end
