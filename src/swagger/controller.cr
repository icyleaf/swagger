module Swagger
  struct Controller
    getter name
    getter description
    getter actions
    getter external_docs

    def initialize(@name : String, @description : String, @actions = [] of Swagger::Action,
                   @external_docs : String? = nil)
    end
  end
end
