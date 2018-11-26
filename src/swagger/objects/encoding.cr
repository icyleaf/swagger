module Swagger::Objects
  # Encoding Object
  #
  # See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#encodingObject
  struct Encoding
    include JSON::Serializable

    @[JSON::Field(key: "contentType")]
    getter content_type : String? = nil
    getter headers : Hash(String, Header)? = nil
    getter style : String? = nil
    getter explode : Bool = false

    @[JSON::Field(key: "allowReserved")]
    getter allow_reserved : Bool = false

    def initialize(@content_type : String? = nil, @headers : Hash(String, Header)? = nil,
                   @style : String? = nil, @explode : Bool = false, @allow_reserved : Bool = false)
    end
  end
end
