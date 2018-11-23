module Swagger::Object
  struct Schema
    include JSON::Serializable

    def self.reference(name)
      new(ref: "#/components/schemas/#{name}")
    end

    getter type : String? = nil
    getter required : Array(String)? = nil
    getter properties : Hash(String, Property)? = nil

    @[JSON::Field(key: "$ref")]
    getter ref : String? = nil

    def initialize(@type : String? = nil, @required : Array(String)? = nil,
                   @properties : Hash(String, Property)? = nil, @ref : String? = nil)
    end
  end
end
