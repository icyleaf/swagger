module Swagger::Object
  struct Example
    include JSON::Serializable

    getter summary : String? = nil
    getter description : String? = nil
    getter value : String? = nil

    @[JSON::Field(key: "externalValue")]
    getter external_value : String? = nil

    @[JSON::Field(key: "$ref")]
    getter ref : String? = nil

    def initialize(@summary : String? = nil, @description : String? = nil, @value : String? = nil,
                   @external_value : String? = nil, @ref : String? = nil)

    end
  end
end
