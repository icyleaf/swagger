module Swagger::Objects
  struct Property
    include JSON::Serializable

    def self.use_reference(name : String)
      new(ref: "#/components/schemas/#{name}")
    end

    getter type : String? = nil
    getter items : Schema? = nil
    getter description : String? = nil
    getter default : (String | Int32 | Int64 | Float64 | Bool)? = nil
    getter example : (String | Int32 | Int64 | Float64 | Bool)? = nil
    getter required : Bool? = nil
    @[JSON::Field(key: "enum")]
    getter enum_values : Array(String)? = nil

    @[JSON::Field(key: "$ref")]
    getter ref : String? = nil

    def initialize(@type : String? = nil, @description : String? = nil, @items : Schema? = nil,
                   @default : (String | Int32 | Int64 | Float64 | Bool)? = nil,
                   @example : (String | Int32 | Int64 | Float64 | Bool)? = nil,
                   @required : Bool? = nil, @ref : String? = nil,
                   @enum_values : Array(String)? = nil)
    end
  end
end
