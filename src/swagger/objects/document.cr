module Swagger::Objects
  struct Document
    include JSON::Serializable

    @[JSON::Field(key: "openapi")]
    property openapi_version : String = "3.0.3"
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
