module Swagger::Objects
  struct Document
    include JSON::Serializable

    property openapi = Swagger::OPENAPI_VERSION
    property info : Objects::Info
    property paths : Hash(String, Objects::PathItem)
    property servers : Array(Objects::Server)? = nil
    property tags : Array(Objects::Tag)? = nil
    property security : Hash(String, Array(String))? = nil
    property components : Objects::Components? = nil

    def initialize(@info : Objects::Info, @paths : Hash(String, Objects::PathItem),
                   @servers : Array(Objects::Server)? = nil, @tags : Array(Objects::Tag)? = nil,
                   @security : Hash(String, Array(String))? = nil, @components : Objects::Components? = nil)
    end
  end
end
