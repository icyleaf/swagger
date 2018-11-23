module Swagger
  struct Request
    property name
    property description
    property content_type

    def initialize(@name : String, @description : String? = nil, @content_type : String? = nil)
    end
  end
end
