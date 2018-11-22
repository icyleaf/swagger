module Swagger::Object
  struct ExternalDocumentation
    include JSON::Serializable

    getter url : String
    getter description : String? = nil

    def initialize(@url : String, @description : String? = nil)
    end
  end
end
