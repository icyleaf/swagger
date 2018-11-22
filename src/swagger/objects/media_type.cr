module Swagger::Object
  struct MediaType
    include JSON::Serializable

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
