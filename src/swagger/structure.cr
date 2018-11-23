module Swagger
  struct Structure
    property name : String
    property properties : Hash(String, String)

    def initialize(@name, @properties)
    end
  end
end
