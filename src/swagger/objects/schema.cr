require "json"

require "./property"

module Swagger::Objects
  # Schema Object
  #
  # See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.3.md#schemaObject
  struct Schema
    include JSON::Serializable

    def self.use_reference(name : String)
      new(ref: "#/components/schemas/#{name}")
    end

    # See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.3.md#dataTypes
    getter type : String? = nil
    getter format : String? = nil
    getter required : Array(String)? = nil
    getter default : (String | Int32 | Int64 | Float64 | Bool)? = nil
    getter properties : Hash(String, Property)? = nil

    @[JSON::Field(key: "$ref")]
    getter ref : String? = nil

    def initialize(@type : String? = nil, @format : String? = nil, @required : Array(String)? = nil,
                   @default : (String | Int32 | Int64 | Float64 | Bool)? = nil,
                   @properties : Hash(String, Property)? = nil, @ref : String? = nil)
    end
  end
end
