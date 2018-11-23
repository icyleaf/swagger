module Swagger
  struct Parameter
    getter name
    getter type
    getter parameter_location
    getter description
    getter required
    getter allow_empty_value
    getter deprecated
    getter ref

    def initialize(@name : String, @parameter_location : String, @type = "string",
                   @description : String? = nil, @required = false, @allow_empty_value = false,
                   @deprecated = false, @ref : String? = nil)
    end
  end
end
