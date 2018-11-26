module Swagger
  struct Parameter
    property name
    property type
    property format
    property parameter_location
    property description
    property default_value
    property required
    property allow_empty_value
    property deprecated
    property ref

    def initialize(@name : String, @parameter_location : String, @type = "string", @description : String? = nil,
                   @default_value : (String | Int32 | Int64 | Float64 | Bool)? = nil, @format : String? = nil,
                   @required = false, @allow_empty_value = false, @deprecated = false, @ref : String? = nil)
    end
  end
end
