module Swagger
  # Object is define a schema struct
  #
  # > This is no relationship with `Objects` structs.
  #
  # ```
  # Swagger::Object.new("User", "object", [
  #     Swagger::Property.new("id", "integer", "int32", example: 1),
  #     Swagger::Property.new("nickname", example: "icyleaf wang"),
  #     Swagger::Property.new("username", example: "icyleaf"),
  #     Swagger::Property.new("email", example: "icyleaf.cn@gmail.com"),
  #     Swagger::Property.new("bio", "Personal bio"),
  # ])
  # ```
  struct Object
    property name
    property type
    property properties

    def initialize(@name : String, @type : String, @properties : Array(Property))
    end
  end
end
