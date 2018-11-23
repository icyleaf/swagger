module Swagger
  struct Controller
    property name
    property description
    property actions
    property external_docs

    def initialize(@name : String, @description : String, @actions = [] of Swagger::Action,
                   @external_docs : String? = nil)
    end
  end
end
