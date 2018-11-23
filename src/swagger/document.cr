module Swagger
  struct Document
    property openapi = Swagger::OPENAPI_VERSION
    property info
    property paths
    property servers
    property tags
    property security
    property components

    def initialize(@info : Object::Info, @paths : Hash(String, Object::PathItem),
                   @servers : Array(Object::Server)? = nil, @tags : Array(Object::Tag)? = nil,
                   @security : Array(String)? = nil, @components : Hash(String, Object::Schema)? = nil)
    end
  end
end
