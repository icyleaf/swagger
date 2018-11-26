module Swagger
  struct Property
    getter name
    getter type
    getter format
    getter description
    getter default_value
    getter example

    def initialize(@name : String, @type : String = "string", @format : String? = nil,
                   @description : String? = nil, @default_value : (String | Int32 | Int64 | Float64 | Bool)? = nil,
                   @example : (String | Int32 | Int64 | Float64 | Bool)? = nil)
    end
  end
end
