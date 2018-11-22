module Swagger::Object
  struct Tag
    include JSON::Serializable

    getter name : String
    getter description : String? = nil

    @[JSON::Field(key: "externalDocs")]
    getter external_docs : ExternalDocumentation? = nil

    def initialize(@name : String, @description : String? = nil, @external_docs : ExternalDocumentation? = nil)
    end
  end
end
