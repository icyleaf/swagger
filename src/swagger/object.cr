module Swagger
  struct Object
    property name
    property type
    property properties

    def initialize(@name : String, @type : String, @properties : Array(Property))
    end
  end
end
