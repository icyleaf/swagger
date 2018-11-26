module Swagger::Object
  # Schema Object
  #
  # See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#schemaObject
  struct Schema
    include JSON::Serializable

    def self.reference(name)
      new(ref: "#/components/schemas/#{name}")
    end

    getter type : String? = nil
    getter required : Array(String)? = nil
    getter default : (String | Int32 | Int64 | Float64 | Bool)? = nil
    getter properties : Hash(String, Property)? = nil

    @[JSON::Field(key: "$ref")]
    getter ref : String? = nil

    def initialize(@type : String? = nil, @required : Array(String)? = nil, @default : (String | Int32 | Int64 | Float64 | Bool)? = nil,
                   @properties : Hash(String, Property)? = nil, @ref : String? = nil)
    end
  end
end
