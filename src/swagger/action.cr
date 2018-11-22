module Swagger
  struct Action
    getter method
    getter route
    getter summary
    getter description
    getter parameters
    getter request
    getter responses
    getter authorization

    # TODO: request
    def initialize(@method : String, @route : String, @summary : String? = nil, @parameters : Array(Parameter)? = nil,
                   @description : String? = nil, @request : String? = nil, @responses : Array(Response)? = nil,
                   @authorization = false)
    end
  end
end
