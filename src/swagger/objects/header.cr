module Swagger::Objects
  # Header Object
  #
  # See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.3.md#headerObject
  struct Header
    include JSON::Serializable

    getter name : String

    @[JSON::Field(key: "in")]
    getter parameter_location : String

    getter description : String? = nil
    getter required : Bool = false

    @[JSON::Field(key: "allowEmptyValue")]
    getter allow_empty_value : Bool = false

    getter deprecated : Bool = false

    @[JSON::Field(key: "$ref")]
    getter ref : String? = nil

    def initialize(@name : String, @parameter_location : String, @description : String? = nil,
                   @required = false, @deprecated = false, @allow_empty_value = false)
    end
  end
end
