module Swagger::Objects
  struct Property
    include JSON::Serializable

    getter type : String
    getter description : String? = nil
    getter default : (String | Int32 | Int64 | Float64 | Bool)? = nil
    getter examples : String? = nil

    def initialize(@type : String, @description : String? = nil,
                   @default : (String | Int32 | Int64 | Float64 | Bool)? = nil,
                   @examples : String? = nil)
    end
  end
end
