module Swagger::Objects
  struct Property
    include JSON::Serializable

    getter type : String
    getter items : Schema? = nil
    getter description : String? = nil
    getter default : (String | Int32 | Int64 | Float64 | Bool)? = nil
    getter example : (String | Int32 | Int64 | Float64 | Bool)? = nil
    getter required : Bool? = nil

    def initialize(@type : String, @description : String? = nil, @items : Schema? = nil,
                   @default : (String | Int32 | Int64 | Float64 | Bool)? = nil,
                   @example : (String | Int32 | Int64 | Float64 | Bool)? = nil,
                   @required : Bool? = nil)
    end
  end
end
