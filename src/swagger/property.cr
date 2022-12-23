module Swagger
  struct Property
    property name
    property type
    property format
    property items
    property description
    property default_value
    property example
    property required
    property ref
    property enum_values

    def initialize(@name : String, @type : String = "string", @format : String? = nil,
                   @items : (Object | String)? = nil, @description : String? = nil,
                   @default_value : (String | Int32 | Int64 | Float64 | Bool)? = nil,
                   @example : (String | Int32 | Int64 | Float64 | Bool)? = nil,
                   @required : Bool? = nil, @ref : String? = nil,
                   @enum_values : Array(String)? = nil)
    end
  end
end
