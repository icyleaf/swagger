module Swagger
  struct Server
    property url
    property description
    property variables

    def initialize(@url : String, @description : String? = nil,
                   @variables : Array(Variable)? = nil)
    end

    struct Variable
      property name
      property default_value
      property enum_values
      property description

      def initialize(@name : String, @default_value : String, @enum_values : Array(String)? = nil, @description : String? = nil)
      end
    end
  end
end
