module Swagger::Object
  # Media Type Object
  #
  # See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#mediaTypeObject
  struct MediaType
    include JSON::Serializable

    def self.schema_reference(schema_name)
      new(Schema.reference(schema_name))
    end

    getter schema : Schema? = nil
    getter example : String? = nil
    getter examples : Hash(String, Example)? = nil
    getter encoding : Hash(String, Encoding)? = nil

    @[JSON::Field(key: "$ref")]
    getter ref : String? = nil

    def initialize(@schema : Schema? = nil, @example : String? = nil,
                   @examples : Hash(String, Example)? = nil, @encoding : Hash(String, Encoding)? = nil,
                   @ref : String? = nil)
    end
  end
end
