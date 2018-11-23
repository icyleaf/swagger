module Swagger
  struct Action
    property method
    property route
    property summary
    property description
    property parameters
    property request
    property responses
    property authorization
    property deprecated

    def initialize(@method : String, @route : String, @summary : String? = nil, @parameters : Array(Parameter)? = nil,
                   @description : String? = nil, @request : Request? = nil, @responses : Array(Response)? = nil,
                   @authorization = false, @deprecated = false)
    end
  end
end
