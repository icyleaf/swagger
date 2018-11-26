module Swagger::Object
  struct ExternalDocs
    include JSON::Serializable

    getter url : String
    getter description : String? = nil

    def initialize(@url : String, @description : String? = nil)
    end
  end
end

alias Swagger::ExternalDocs = Swagger::Object::ExternalDocs
