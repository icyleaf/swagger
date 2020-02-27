module Swagger::Objects
  # External Documentation Object
  #
  # See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.3.md#externalDocumentationObject
  struct ExternalDocs
    include JSON::Serializable

    getter url : String
    getter description : String? = nil

    def initialize(@url : String, @description : String? = nil)
    end
  end
end
