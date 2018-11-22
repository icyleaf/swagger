module Swagger
  struct Response
    property code : String
    property description : String
    property object : JSON::Any::Type? = nil
    property array : JSON::Any::Type? = nil
    property content_type : String? = nil

    def initialize(@code : String, @description : String,
                   @object : JSON::Any::Type? = nil, @array : JSON::Any::Type? = nil,
                   @content_type : String? = nil)
    end
  end
end
