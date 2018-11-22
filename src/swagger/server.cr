module Swagger
  struct Server
    getter url
    getter description
    getter variables

    def initialize(@url : String, @description : String? = nil,
                   @variables : Array(Variable)? = nil)
    end

    struct Variable
      getter name
      getter default_value
      getter enum_values
      getter description

      def initialize(@name : String, @default_value : String, @enum_values : Array(String)? = nil, @description : String? = nil)
      end
    end
  end
end
