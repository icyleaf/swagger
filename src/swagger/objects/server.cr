module Swagger::Object
  struct Server
    include JSON::Serializable

    getter url : String
    getter description : String? = nil
    getter variables : Hash(String, Variable)? = nil

    def initialize(@url : String, @description : String? = nil,
                   @variables : Hash(String, Variable)? = nil)
    end

    struct Variable
      include JSON::Serializable

      @[JSON::Field(key: "default")]
      getter default_value : String

      @[JSON::Field(key: "enum")]
      getter enum_values : Array(String)? = nil

      getter description : String? = nil

      def initialize(@default_value : String, @enum_values : Array(String)? = nil, @description : String? = nil)
      end
    end
  end
end
