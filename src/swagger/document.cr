module Swagger
  struct Document
    include JSON::Serializable

    property openapi = Swagger::OPENAPI_VERSION
    property info : Object::Info
    property paths : Hash(String, Object::PathItem)
    property servers : Array(Object::Server)? = nil
    property tags : Array(Object::Tag)? = nil
    property security : Hash(String, Array(String))? = nil
    property components : Object::Components? = nil

    def initialize(@info : Object::Info, @paths : Hash(String, Object::PathItem),
                   @servers : Array(Object::Server)? = nil, @tags : Array(Object::Tag)? = nil,
                   @security : Hash(String, Array(String))? = nil, @components : Object::Components? = nil)
    end
  end
end
