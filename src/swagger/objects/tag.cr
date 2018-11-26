module Swagger::Object
  # Tag Object
  #
  # See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#tagObject
  struct Tag
    include JSON::Serializable

    getter name : String
    getter description : String? = nil

    @[JSON::Field(key: "externalDocs")]
    getter external_docs : ExternalDocs? = nil

    def initialize(@name : String, @description : String? = nil, @external_docs : ExternalDocs? = nil)
    end
  end
end
