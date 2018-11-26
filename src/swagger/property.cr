module Swagger
  struct Property
    property name
    property type
    property format
    property description
    property default_value
    property example
    property required

    def initialize(@name : String, @type : String = "string", @format : String? = nil,
                   @description : String? = nil, @default_value : (String | Int32 | Int64 | Float64 | Bool)? = nil,
                   @example : (String | Int32 | Int64 | Float64 | Bool)? = nil,
                   @required : Bool? = nil)
    end
  end
end
